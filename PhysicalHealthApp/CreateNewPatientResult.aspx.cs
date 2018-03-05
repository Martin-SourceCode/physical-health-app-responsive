using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class CreateNewPatientResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = "";
                try
                {
                    id = Request.QueryString["id"].ToString();
                }
                catch
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                this.hdnPatientID.Value = id;

                GetPatientData(id);

                switch (Session["userType"].ToString().ToLower())
                {
                    case "patient":
                        Response.Redirect("Unauthorised.aspx");
                        //this.lblSummaryType.Text = "My Summary";
                        //if (id != Session["userID"].ToString())
                        //{
                        //    Response.Redirect("Unauthorised.aspx");
                        //}
                        break;
                    case "clinician":
                        this.lblSummaryType.Text = "New Result";
                        if (Session["userID"].ToString() != this.hdnMatchedclinicianid.Value)
                        {
                            Response.Redirect("Unauthorised.aspx");
                        }
                        break;
                    case "super user":
                        Response.Redirect("Unauthorised.aspx");
                        break;
                }



            }
        }



        private void GetPatientData(string id)
        {
            string sql = "SELECT * FROM app_user WHERE userid = CAST(@userid AS INT);";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("userid", id)
            };



            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {

                string userFullName = dt.Rows[0]["firstname"].ToString() + " " + dt.Rows[0]["lastname"].ToString();
                try
                {
                    this.lblPatientName.Text = userFullName.ToUpper();
                }
                catch { }

                try
                {
                    this.lblNHS.Text = dt.Rows[0]["nhsnumber"].ToString();
                }
                catch { }

                try
                {
                    this.lblDoB.Text = dt.Rows[0]["dateofbirth"].ToString().Substring(0, 10); ;
                }
                catch { }

                try
                {
                    this.hdnMatchedclinicianid.Value = dt.Rows[0]["matchedclinicianid"].ToString();
                }
                catch { }
            }
        }

        protected void btnCreateNewTest_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNewPatientResult.aspx?id=" + this.hdnPatientID.Value);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("PatientSummary.aspx?id=" + this.hdnPatientID.Value);
        }

    }
}