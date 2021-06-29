using System.Linq;

namespace PerformanceNetCore.Repository
{
    public interface IRepository<TEntity> where TEntity : class
    {
        IQueryable<TEntity> All { get; }
        TEntity Find(int key);
        void Incluir(params TEntity[] obj);
        void Alterar(params TEntity[] obj);
        void Excluir(params TEntity[] obj);
    }
}