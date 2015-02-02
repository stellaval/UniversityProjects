using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace WebAppEventManagement
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            //Search
            if (TextBoxEvID.Text != "")
            {
                TextBoxEvName.Enabled = false;
                try
                {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Event WHERE EventID=@id";
                    SqlDataSource1.SelectParameters.Add("id", TextBoxEvID.Text);
                }
                catch (SqlException ol)
                {
                    lblErr.Text = ol.Message.ToString();
                }
            }

            if (TextBoxEvName.Text != "")
            {
                TextBoxEvID.Enabled = false;
                try
                {
                    SqlDataSource1.SelectParameters.Clear();
                    SqlDataSource1.SelectCommand = "SELECT * FROM Event WHERE EventName=@name";
                    SqlDataSource1.SelectParameters.Add("name", TextBoxEvName.Text);
                }
                catch (SqlException ol)
                {
                    lblErr.Text = ol.Message.ToString();
                }
            }
        }

        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            TextBoxEvID.Text = "";
            TextBoxEvName.Text = "";
            TextBoxEvID.Enabled = true;
            TextBoxEvName.Enabled = true;
            try
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM Event";
            }
            catch (SqlException se)
            {
                lblErr.Text = se.Message.ToString();
            }
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridView1.DataBind();
        }
    }
}