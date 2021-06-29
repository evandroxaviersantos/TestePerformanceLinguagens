using Microsoft.EntityFrameworkCore;
using PerformanceNetCore.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PerformanceNetCore.Repository
{
    public class ClienteContext : DbContext
    {

        public DbSet<Cliente> Clientes { get; set; }

        public ClienteContext(DbContextOptions<ClienteContext> options)
            : base(options)
        {
            //irá criar o banco e a estrutura de tabelas necessárias
            this.Database.EnsureCreated();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfiguration<Cliente>(new ClienteConfiguration());
        }

    }
}
