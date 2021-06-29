using System.Linq;


namespace PerformanceNetCore.Repository
{
    public class RepositorioBaseEF<TEntity> : IRepository<TEntity> where TEntity : class
    {
        private readonly ClienteContext _context;

        public RepositorioBaseEF(ClienteContext context)
        {
            _context = context;
        }

        public IQueryable<TEntity> All => _context.Set<TEntity>().AsQueryable();

        public TEntity Find(int key)
        {
            return _context.Find<TEntity>(key);
        }
        public void Incluir(params TEntity[] obj)
        {
            _context.Set<TEntity>().AddRange(obj);
            _context.SaveChanges();
        }
        public void Alterar(params TEntity[] obj)
        {
            _context.Set<TEntity>().UpdateRange(obj);
            _context.SaveChanges();
        }
        public void Excluir(params TEntity[] obj)
        {
            _context.Set<TEntity>().RemoveRange(obj);
            _context.SaveChanges();
        }
    }
}
