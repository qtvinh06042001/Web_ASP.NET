using OnlineShop.Context;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class HomeController : Controller
    {
        ShopEntities1 objModel =  new ShopEntities1();
        
        public ActionResult AllProduct(string SearchString)
        {
            var lstProduct = objModel.Product.ToList();
            if (!String.IsNullOrEmpty(SearchString))
            {
                lstProduct = objModel.Product.Where(n => n.Name.Contains(SearchString)).ToList();
            }
            else
            {
                lstProduct = objModel.Product.ToList();
            }
            var lstCategory = objModel.Category.ToList(); 
            Product_Category objProduct_Category = new Product_Category();
            objProduct_Category.ListCategory = lstCategory;
            objProduct_Category.ListProduct = lstProduct;
            return View(objProduct_Category);
        }
        public ActionResult Index()
        {
            var lstCategory = objModel.Category.ToList();
            var lstProduct = objModel.Product.OrderByDescending(x => x.Id).Take(4).ToList();
            Product_Category objProduct_Category = new Product_Category();
            objProduct_Category.ListCategory = lstCategory;
            objProduct_Category.ListProduct = lstProduct;
            return View(objProduct_Category);
        }
        //GET: Register
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
        //POST: Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Users _user)
        {
            if (ModelState.IsValid)
            {
                var check = objModel.Users.FirstOrDefault(n => n.Email == _user.Email);
                if (check == null)
                {
                    _user.Password = GetMD5(_user.Password);
                    objModel.Configuration.ValidateOnSaveEnabled = false;
                    objModel.Users.Add(_user);
                    objModel.SaveChanges();
                    return RedirectToAction("Login");
                }
                else
                {
                    ViewBag.error = "Email đã tồn tại";
                    return View();
                }
            }
            return View();
        }
        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] formData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(formData);
            string byte2String = null;
            for(int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");
            }
            return byte2String;
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string email,string password)
        {
            if (ModelState.IsValid)
            {
                var f_password = GetMD5(password);
                var data = objModel.Users.Where(n => n.Email.Equals(email) && n.Password == f_password);
                if (data.Count() > 0)
                {
                    Session["Fullname"] = data.FirstOrDefault().FirstName + " " + data.FirstOrDefault().LastName;
                    Session["Email"] = data.FirstOrDefault().Email;
                    Session["idUser"] = Convert.ToInt32(data.FirstOrDefault().idUser);
                    if (Session["Email"].ToString() == "admin@gmail.com")
                    {
                        Session["Admin"] = 1;
                    }
                    else
                    {
                        Session["Admin"] = null;
                    }
                    
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.error = "Sai tên đăng nhập hoặc mật khẩu";
                    return RedirectToAction("Login");
                }
                
            }
            return View();
        }
        
        [HttpGet]
        public ActionResult ChangePassword(int Id)
        {
            Session["idUser"] = Id;
            var objUser = objModel.Users.FirstOrDefault(n => n.idUser == Id);
            return View(objUser);
        }
        [HttpPost]
        public ActionResult ChangePassword(int Id, FormCollection f)
        {
        
            Session["idUser"] = Id;
            var objUser = objModel.Users.FirstOrDefault(n => n.idUser == Id);
            if (objUser.Password == GetMD5(f["oldPassword"]))
            {
                var newpass = f["newPassword"];
                var confirmpass = f["confirmpass"];
                if (newpass == confirmpass)
                {
                    objUser.Password = GetMD5(newpass);
                    objModel.SaveChanges();
                    ViewBag.error = "Đổi mật khẩu thành công!";
                }
                else
                {
                    ViewBag.error2 = "Không khớp với mật khẩu bạn vừa nhập!";
                }  
            }
            else
            {
                ViewBag.error1 = "Bạn nhập sai mật khẩu hiện tại!";
            }

            return RedirectToAction("Login");
        }
         
        [HttpGet]
        public ActionResult Infor(int Id)
        {
            Session["idUser"] = Id;
            var objUser = objModel.Users.FirstOrDefault(n => n.idUser == Id);
            return View(objUser);
        }
        [HttpPost]
        public ActionResult Infor(int Id, FormCollection f)
        {
            Session["idUser"] = Id;
            var objUser = objModel.Users.FirstOrDefault(n => n.idUser == Id);
            var firstN = f["firstName"];
            var lastN = f["lastName"];
            objUser.FirstName = firstN;
            objUser.LastName = lastN;
            objModel.SaveChanges();
            ViewBag.error = "Đổi thông tin thành công!";
            return View(objUser);

        } 
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }
    }
}