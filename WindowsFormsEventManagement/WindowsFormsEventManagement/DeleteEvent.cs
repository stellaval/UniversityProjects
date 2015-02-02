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
    public partial class DeleteEvent : Form
    {
        private string name;
        private int type;
        private int team;
        private int client;
        private string place;
        private string date;
        private string time;
        private string description;
        private int id;


        public string eventNameD
        {
            get { return name; }
            set { name = value; }
        }
        public int eventTypeD
        {
            get { return type; }
            set { type = value; }
        }
        public int eventTeamD
        {
            get { return team; }
            set { team = value; }
        }
        public int eventClientD
        {
            get { return client; }
            set { client = value; }
        }
        public string eventPlaceD
        {
            get { return place; }
            set { place = value; }
        }
        public string eventDateD
        {
            get { return date; }
            set { date = value; }
        }
        public string eventTimeD
        {
            get { return time; }
            set { time = value; }
        }
        public string eventDescriptionD
        {
            get { return description; }
            set { description = value; }
        }
        public int evetIDD
        {
            get { return id; }
            set { id = value; }
        }
        public DeleteEvent()
        {
            InitializeComponent();
        }

        private void DeleteEvent_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'eventManagementDataSet3.Clients' table. You can move, or remove it, as needed.
            this.clientsTableAdapter.Fill(this.eventManagementDataSet3.Clients);
            // TODO: This line of code loads data into the 'eventManagementDataSet2.Teams' table. You can move, or remove it, as needed.
            this.teamsTableAdapter.Fill(this.eventManagementDataSet2.Teams);
            // TODO: This line of code loads data into the 'eventManagementDataSet1.EventTypes' table. You can move, or remove it, as needed.
            this.eventTypesTableAdapter.Fill(this.eventManagementDataSet1.EventTypes);
            
            textBox1.Text = name;
            comboBox1.SelectedValue = type;
            comboBox2.SelectedValue = team;
            comboBox3.SelectedValue = client;
            textBox2.Text = place;
            maskedTextBox1.Text = date;
            maskedTextBox2.Text = time;
            textBox3.Text = description;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            comboBox1.SelectedIndex = -1;
            comboBox2.SelectedIndex = -1;
            comboBox3.SelectedIndex = -1;
            maskedTextBox1.Text = "";
            maskedTextBox2.Text = "";
        }

        private void button1_Click(object sender, EventArgs e)
        {
           
                const string message =
                    "Are you sure that you would like delete the event?";
                const string caption = "Event deleting";
                var result = MessageBox.Show(message, caption,
                                             MessageBoxButtons.OKCancel,
                                             MessageBoxIcon.Question);

                // If the cancel button was pressed ... 
                if (result == DialogResult.Cancel)
                {
                    this.Close();
                }
                else if (result == DialogResult.OK)
                { 
            

            

            SqlConnection connection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True");

            using (connection)
            {
                SqlCommand command = new SqlCommand("deleteEvent", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "deleteEvent";

                SqlParameter idEvent = new SqlParameter("@EventiD", SqlDbType.Int);
                idEvent.Value = id;
                command.Parameters.Add(id);

                SqlParameter eventCount = new SqlParameter("@e_id", SqlDbType.Int);
                eventCount.Direction = ParameterDirection.Output;
                command.Parameters.Add(eventCount);

                try
                {
                    connection.Open();
                    SqlDataReader dr = command.ExecuteReader();
                    int res = (Int32)command.Parameters["@e_id"].Value;
                    if (res != 0)
                    {
                        MessageBox.Show("Deleted Successfully!");
                    }
                    else
                    {
                        MessageBox.Show("Nothing to delete!");
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show(ex.ToString());
                }
            }
            }
        }
    }
}
