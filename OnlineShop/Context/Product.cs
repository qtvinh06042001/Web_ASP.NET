//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace OnlineShop.Context
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            this.OrderDetail = new HashSet<OrderDetail>();
        }
    
        public int Id { get; set; }
        [Required(ErrorMessage ="Bạn phải nhập tên sản phẩm")]
        [MaxLength(250,ErrorMessage ="Tên sản phẩm không được quá 500 kí tự")]
        public string Name { get; set; }
        [Required(ErrorMessage ="Tải lên ảnh sản phẩm")]
        public string Avatar { get; set; }
        [Required(ErrorMessage ="Chọn một danh mục")]
        public int CategoryId { get; set; }
        [Required(ErrorMessage ="Bạn phải nhập mô tả ngắn")]
        public string ShortDes { get; set; }
        [Required(ErrorMessage ="Bạn phải nhập mô tả chi tiết")]
        public string FullDescription { get; set; }
        [Required]
        public Nullable<decimal> Price { get; set; }
    
        public virtual Category Category { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderDetail> OrderDetail { get; set; }
        [NotMapped]
        public System.Web.HttpPostedFileBase ImageUpload { get; set; }
    }
}
