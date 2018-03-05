using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PhysicalHealthApp
{
    public partial class ConfirmAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                this.pnlAlreadyConfirmed.Visible = false;
                this.pnlFailed.Visible = false;
                this.pnlSuccess.Visible = false;

                string id = "";
                try
                {
                    id = Request.QueryString["id"].ToString();
                }
                catch {
                    this.pnlFailed.Visible = true;
                    return;
                }

                ValidateCode(id);


            }
        }

        private void ValidateCode(string code)
        {
           
            bool emailconfirmed = false;

            string sql = "SELECT * FROM app_user WHERE emailvalidationstring = @code;";
            var paramList = new List<KeyValuePair<string, string>>() {
                new KeyValuePair<string, string>("code", code)
            };

            DataSet ds = DataServices.DataSetFromSQL(sql, paramList);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                try { emailconfirmed = System.Convert.ToBoolean(dt.Rows[0]["emailconfirmed"].ToString()); } catch { }

                if(emailconfirmed)
                {
                    this.pnlAlreadyConfirmed.Visible = true;
                    return;
                }
                else
                {
                    this.pnlSuccess.Visible = true;
                    string sqlConfirm = "UPDATE app_user SET emailconfirmed = true, emailconfirmedtimestamp = now() WHERE emailvalidationstring = @code;";
                    DataServices.executeSQLStatement(sqlConfirm, paramList);
                    return;
                }
            }
            else
            {
                this.pnlFailed.Visible = true;
                return;
            }


            


        }
    }
}