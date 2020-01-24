using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace Domain.Models
{
    public partial class PizzaDbContext : DbContext
    {
        public PizzaDbContext()
        {
        }

        public PizzaDbContext(DbContextOptions<PizzaDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Crust> Crust { get; set; }
        public virtual DbSet<CrustInventory> CrustInventory { get; set; }
        public virtual DbSet<Location> Location { get; set; }
        public virtual DbSet<Logins> Logins { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<Pizza> Pizza { get; set; }
        public virtual DbSet<PizzaToppings> PizzaToppings { get; set; }
        public virtual DbSet<Prebuilt> Prebuilt { get; set; }
        public virtual DbSet<Prebuilt1> Prebuilt1 { get; set; }
        public virtual DbSet<PrebuiltToppings> PrebuiltToppings { get; set; }
        public virtual DbSet<Size> Size { get; set; }
        public virtual DbSet<Store> Store { get; set; }
        public virtual DbSet<Topping> Topping { get; set; }
        public virtual DbSet<ToppingInventory> ToppingInventory { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Crust>(entity =>
            {
                entity.ToTable("Crust", "Pizza");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__Crust__5276644BFB8081D2")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasColumnName("description")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .IsFixedLength();
            });

            modelBuilder.Entity<CrustInventory>(entity =>
            {
                entity.HasKey(e => new { e.StoreId, e.Crustid })
                    .HasName("PK_StorexCrust");

                entity.ToTable("CrustInventory", "Store");

                entity.Property(e => e.Amount).HasColumnName("amount");

                entity.HasOne(d => d.Crust)
                    .WithMany(p => p.CrustInventory)
                    .HasForeignKey(d => d.Crustid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__CrustInve__Crust__3B40CD36");

                entity.HasOne(d => d.Store)
                    .WithMany(p => p.CrustInventory)
                    .HasForeignKey(d => d.StoreId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__CrustInve__Store__4865BE2A");
            });

            modelBuilder.Entity<Location>(entity =>
            {
                entity.ToTable("Location", "Store");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__Location__72E12F1B245B0490")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(128)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Logins>(entity =>
            {
                entity.ToTable("Logins", "Logic");

                entity.HasIndex(e => e.Username)
                    .HasName("UQ__tmp_ms_x__F3DBC5721D291903")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasColumnName("password")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasColumnName("username")
                    .HasMaxLength(128)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Orders>(entity =>
            {
                entity.ToTable("Orders", "Orders");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Ordertime)
                    .HasColumnName("ordertime")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("smallmoney");

                entity.Property(e => e.Storeid).HasColumnName("storeid");

                entity.Property(e => e.Userid).HasColumnName("userid");

                entity.HasOne(d => d.Store)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.Storeid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Orders__storeid__65F62111");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.Userid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Orders__userid__66EA454A");
            });

            modelBuilder.Entity<Pizza>(entity =>
            {
                entity.HasKey(e => new { e.OrderId, e.PizzaNum })
                    .HasName("PK_OrderedPizza");

                entity.ToTable("Pizza", "Orders");

                entity.Property(e => e.OrderId).HasColumnName("orderId");

                entity.Property(e => e.PizzaNum).HasColumnName("pizzaNum");

                entity.Property(e => e.CrustId).HasColumnName("crustId");

                entity.Property(e => e.Price)
                    .HasColumnName("price")
                    .HasColumnType("smallmoney");

                entity.Property(e => e.Size).HasColumnName("size");

                entity.HasOne(d => d.Crust)
                    .WithMany(p => p.Pizza)
                    .HasForeignKey(d => d.CrustId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Pizza__crustId__5D60DB10");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.Pizza)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Pizza__orderId__5C6CB6D7");

                entity.HasOne(d => d.SizeNavigation)
                    .WithMany(p => p.Pizza)
                    .HasForeignKey(d => d.Size)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Pizza__size__5E54FF49");
            });

            modelBuilder.Entity<PizzaToppings>(entity =>
            {
                entity.HasKey(e => new { e.OrderId, e.PizzaNum, e.ToppingId });

                entity.ToTable("PizzaToppings", "Orders");

                entity.Property(e => e.OrderId).HasColumnName("orderId");

                entity.Property(e => e.PizzaNum).HasColumnName("pizzaNum");

                entity.Property(e => e.ToppingId).HasColumnName("toppingId");

                entity.Property(e => e.Amount)
                    .HasColumnName("amount")
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Topping)
                    .WithMany(p => p.PizzaToppings)
                    .HasForeignKey(d => d.ToppingId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__PizzaTopp__toppi__7BE56230");

                entity.HasOne(d => d.Pizza)
                    .WithMany(p => p.PizzaToppings)
                    .HasForeignKey(d => new { d.OrderId, d.PizzaNum })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Pizza");
            });

            modelBuilder.Entity<Prebuilt>(entity =>
            {
                entity.ToTable("Prebuilt", "Pizza");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__Prebuilt__77F0C7699B577683")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CrustId).HasColumnName("crustId");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.HasOne(d => d.Crust)
                    .WithMany(p => p.Prebuilt)
                    .HasForeignKey(d => d.CrustId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Prebuilt__crustI__628FA481");
            });

            modelBuilder.Entity<Prebuilt1>(entity =>
            {
                entity.HasKey(e => new { e.StoreId, e.PrebuiltId })
                    .HasName("AK_Prebuilt_Column");

                entity.ToTable("Prebuilt", "Store");

                entity.HasOne(d => d.Prebuilt)
                    .WithMany(p => p.Prebuilt1)
                    .HasForeignKey(d => d.PrebuiltId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Prebuilt__Prebui__4E53A1AA");

                entity.HasOne(d => d.Store)
                    .WithMany(p => p.Prebuilt1)
                    .HasForeignKey(d => d.StoreId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Prebuilt__StoreI__4B422AD5");
            });

            modelBuilder.Entity<PrebuiltToppings>(entity =>
            {
                entity.HasKey(e => new { e.PrebuiltId, e.ToppingId })
                    .HasName("PK_COMPOSITE");

                entity.ToTable("PrebuiltToppings", "Pizza");

                entity.Property(e => e.PrebuiltId).HasColumnName("prebuiltId");

                entity.Property(e => e.ToppingId).HasColumnName("toppingId");

                entity.Property(e => e.Amount)
                    .HasColumnName("amount")
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Prebuilt)
                    .WithMany(p => p.PrebuiltToppings)
                    .HasForeignKey(d => d.PrebuiltId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__PrebuiltT__prebu__5DCAEF64");

                entity.HasOne(d => d.Topping)
                    .WithMany(p => p.PrebuiltToppings)
                    .HasForeignKey(d => d.ToppingId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__PrebuiltT__toppi__5EBF139D");
            });

            modelBuilder.Entity<Size>(entity =>
            {
                entity.ToTable("Size", "Pizza");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__Size__72E12F1B937A3E6F")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(32)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Store>(entity =>
            {
                entity.ToTable("Store", "Store");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__tmp_ms_x__72E12F1B0B83ABE1")
                    .IsUnique();

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .ValueGeneratedNever();

                entity.Property(e => e.Location).HasColumnName("location");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(128)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.Store)
                    .HasForeignKey<Store>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Store_ToLogin");

                entity.HasOne(d => d.LocationNavigation)
                    .WithMany(p => p.Store)
                    .HasForeignKey(d => d.Location)
                    .HasConstraintName("FK__Store__location__4959E263");
            });

            modelBuilder.Entity<Topping>(entity =>
            {
                entity.ToTable("Topping", "Pizza");

                entity.HasIndex(e => e.Name)
                    .HasName("UQ__Topping__51D2CD4C96653413")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .IsFixedLength();
            });

            modelBuilder.Entity<ToppingInventory>(entity =>
            {
                entity.HasKey(e => new { e.StoreId, e.ToppingId })
                    .HasName("PK_StorexTopping");

                entity.ToTable("ToppingInventory", "Store");

                entity.Property(e => e.Amount).HasColumnName("amount");

                entity.HasOne(d => d.Store)
                    .WithMany(p => p.ToppingInventory)
                    .HasForeignKey(d => d.StoreId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__ToppingIn__Store__4A4E069C");

                entity.HasOne(d => d.Topping)
                    .WithMany(p => p.ToppingInventory)
                    .HasForeignKey(d => d.ToppingId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__ToppingIn__Toppi__0880433F");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.ToTable("Users", "Users");

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .ValueGeneratedNever();

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.Users)
                    .HasForeignKey<Users>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Users__id__4F12BBB9");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
