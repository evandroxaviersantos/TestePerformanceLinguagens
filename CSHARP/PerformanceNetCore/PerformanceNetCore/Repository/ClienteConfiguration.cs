using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PerformanceNetCore.Model;

namespace PerformanceNetCore.Repository
{
    public class ClienteConfiguration : IEntityTypeConfiguration<Cliente>
    {
        public void Configure(EntityTypeBuilder<Cliente> builder)
        {
            builder
                .HasKey(c => c.id);

            builder
                .Property(l => l.nome)
                .IsRequired();

            builder
                .Property(l => l.endereco);

            builder
                .Property(l => l.cpf);
        }
    }
}
