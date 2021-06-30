package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

type Cliente struct {
	Id       int    `json:"id"`
	Nome     string `json:"nome"`
	Endereco string `json:"endereco"`
	Cpf      string `json:"cpf"`
}

const (
	host     = "127.0.0.1"
	port     = 5432
	user     = "postgres"
	password = "postgres"
	dbname   = "postgres"
)

func OpenConnection() *sql.DB {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	return db
}

func GETPing(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, `Pong`)
}

func GETHandler(w http.ResponseWriter, r *http.Request) {
	db := OpenConnection()

	rows, err := db.Query("SELECT id,nome,endereco,cpf FROM clientego")
	if err != nil {
		log.Fatal(err)
	}

	var cliente []Cliente

	for rows.Next() {
		var pessoa Cliente
		rows.Scan(&pessoa.Id, &pessoa.Nome, &pessoa.Endereco, &pessoa.Cpf)
		cliente = append(cliente, pessoa)
	}

	peopleBytes, _ := json.MarshalIndent(cliente, "", "\t")

	w.Header().Set("Content-Type", "application/json")
	w.Write(peopleBytes)

	defer rows.Close()
	defer db.Close()
}

func POSTHandler(w http.ResponseWriter, r *http.Request) {
	db := OpenConnection()

	var p Cliente
	err := json.NewDecoder(r.Body).Decode(&p)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	sqlStatement := `INSERT INTO clientego (nome, endereco, cpf) VALUES ($1, $2, $3)`
	_, err = db.Exec(sqlStatement, p.Nome, p.Endereco, p.Cpf)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		panic(err)
	}

	w.WriteHeader(http.StatusOK)
	defer db.Close()
}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/ping", GETPing)
	router.HandleFunc("/api/clientes", GETHandler)
	router.HandleFunc("/api/cliente", POSTHandler)

	log.Fatal(http.ListenAndServe(":9800", router))
}
