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

    public partial class News
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Bạn phải nhập tên tin tức")]
        [MaxLength(500, ErrorMessage = "Tên danh mục không được quá 500 kí tự")]
        public string Name { get; set; }
        [Required(ErrorMessage ="Bạn phải nhập mô tả ngắn")]
        public string ShortDes { get; set; }
        [Required(ErrorMessage ="Bạn phải nhập mô tả chi tiết")]
        public string FullDescription { get; set; }
        public string Avatar { get; set; }
        [NotMapped]
        public System.Web.HttpPostedFileBase ImageUpload { get; set; }
    }
}
