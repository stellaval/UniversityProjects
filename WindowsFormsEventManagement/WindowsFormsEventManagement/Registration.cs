using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace WindowsFormsEventManagement
{
    public partial class Registration : Form
    {
        public Registration()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True");
            using (connection)
            {
                SqlCommand command = new SqlCommand("insertUsers", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "insertUsers";

                SqlParameter username = new SqlParameter("@username", SqlDbType.NVarChar);
                username.Value = textBox1.Text;
                command.Parameters.Add(username);

                SqlParameter password = new SqlParameter("@password", SqlDbType.NVarChar);
                password.Value = textBox2.Text;
                command.Parameters.Add(password);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    MessageBox.Show("Registration successful!");
                    this.Hide();
                    Login loginForm = new Login();
                    loginForm.ShowDialog();

                }
                catch (SqlException ol)
                {
                    MessageBox.Show(ol.ToString());
                }

               
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Registration_Load(object sender, EventArgs e)
        {
            MessageBox.Show("Add new user");
        }
    }
}
