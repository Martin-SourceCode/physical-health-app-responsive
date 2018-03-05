using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PhysicalHealthApp
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            DataTable dt = null;
            try
            {
                dt = (Session["UserDetailsSxn"]) as DataTable;
            }
            catch
            {
                dt = null;
            }

            string userType = "";
            try
            {
                userType = Session["userType"].ToString().ToLower();
            } catch { }

            switch(userType)
            {
                case "patient":
                    Response.Redirect("PatientSummary.aspx?id=" + Session["userID"].ToString());
                    break;
                case "clinician":
                    Response.Redirect("ClinicianSummary.aspx?id=" + Session["userID"].ToString());
                    break;
                case "super user":
                    Response.Redirect("AdminSummary.aspx?id=" + Session["userID"].ToString());
                    break;
            }


        }
    }
}