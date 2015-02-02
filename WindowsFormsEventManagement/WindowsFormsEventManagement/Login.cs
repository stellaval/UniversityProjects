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
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True");
            sqlConnection.Open();
            SqlCommand command = new SqlCommand("select * from Users where UserName = '" + textBox1.Text + "' and Password = '" + textBox2.Text + "'", sqlConnection);
            SqlDataReader dataReader;
            dataReader = command.ExecuteReader();
            int count = 0;
            while (dataReader.Read())
            {
                count += 1;
            }
            if (count == 1)
            {
                MessageBox.Show("Login successful!");
                this.Hide();
            }
            else if (count > 0)
            {
                MessageBox.Show("Duplicated username or password!");
            }
            else 
            {
                MessageBox.Show("Username or Password not correct!");
            }
            textBox1.Clear();
            textBox2.Clear();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Registration reg = new Registration();
            reg.ShowDialog();
            this.Hide();
        }
    }
}
