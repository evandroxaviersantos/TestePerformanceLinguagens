using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PerformanceNetCore.Data;
using PerformanceNetCore.Model;

namespace PerformanceNetCore.Controllers
{
    [Route("api/noassync/[controller]")]
    [ApiController]
    public class ClienteControllerNoAssync : ControllerBase
    {
        private readonly PerformanceNetCoreContext _context;

        public ClienteControllerNoAssync(PerformanceNetCoreContext context)
        {
            _context = context;
        }

        // GET: api/Clientes
        [HttpGet]
        public ActionResult<IEnumerable<Cliente>> GetCliente()
        {
            return _context.Cliente.ToList();
        }        
        
        // POST: api/Clientes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public IActionResult PostCliente(Cliente cliente)
        {
            _context.Cliente.Add(cliente);
            _context.SaveChanges();

            return Ok(cliente);
        }


        private bool ClienteExists(int id)
        {
            return _context.Cliente.Any(e => e.id == id);
        }
    }
}