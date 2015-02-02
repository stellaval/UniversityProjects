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
    public partial class EditEvent : Form
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

        public string eventName
        {
            get { return name; }
            set { name = value; }
        }
        public int eventType
        {
            get { return type; }
            set { type = value; }
        }
        public int eventTeam
        {
            get { return team; }
            set { team = value; }
        }
        public int eventClient
        {
            get { return client; }
            set { client = value; }
        }
        public string eventPlace
        {
            get { return place; }
            set { place = value; }
        }
        public string eventDate
        {
            get { return date; }
            set { date = value; }
        }
        public string eventTime
        {
            get { return time; }
            set { time = value; }
        }
        public string eventDescription
        {
            get { return description; }
            set { description = value; }
        }
        public int evetID
        {
            get { return id; }
            set { id = value; }
        }


        

        public EditEvent()
        {
            InitializeComponent();
            
        }


        


        private void EditEvent_Load(object sender, EventArgs e)
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

        private void button1_Click(object sender, EventArgs e)
        {
            
            string date2 = maskedTextBox1.Text;
            string time2 = maskedTextBox2.Text;
            DateTime date22 = Convert.ToDateTime(date2);
            DateTime time22 = Convert.ToDateTime(time2);

            SqlConnection sqlConnection = new SqlConnection(@"Data Source=STELLA\MSSQLSERVER2012;Initial Catalog=EventManagement;Integrated Security=True"); 

            using (sqlConnection)
           {
               SqlCommand command = new SqlCommand("UpdateEvent", sqlConnection);
               command.CommandType = CommandType.StoredProcedure;
               command.CommandText = "updateEvent";

               SqlParameter idEvent = new SqlParameter("@EventID", SqlDbType.Int);
               idEvent.Value = id;
               command.Parameters.Add(idEvent);

                SqlParameter name = new SqlParameter("@EventName", SqlDbType.NVarChar);
                name.Value=textBox1.Text;
                command.Parameters.Add(name);

                SqlParameter type = new SqlParameter("@EventType", SqlDbType.Int);
                type.Value=comboBox1.SelectedValue;
                command.Parameters.Add(type);

                SqlParameter team = new SqlParameter("@Team", SqlDbType.Int);
                team.Value=comboBox2.SelectedValue;
                command.Parameters.Add(team);

                SqlParameter client =  new SqlParameter("@Client", SqlDbType.Int);
                client.Value=comboBox3.SelectedValue;
                command.Parameters.Add(client);

                SqlParameter place = new SqlParameter("@Place", SqlDbType.NVarChar);
                place.Value=textBox2.Text;
                command.Parameters.Add(place);

                SqlParameter date = new SqlParameter("@Date",SqlDbType.Date);
                date.Value=date22;
                command.Parameters.Add(date);

                SqlParameter time = new SqlParameter("@Time", SqlDbType.Time);
                time.Value = time22;
                command.Parameters.Add(time);

                SqlParameter description = new SqlParameter("@Description", SqlDbType.NVarChar);
                description.Value=textBox3.Text;
                command.Parameters.Add(description);

                try
               {
                   sqlConnection.Open();
                   command.ExecuteNonQuery();
                   MessageBox.Show("You have successfully updated event!");
               }
               catch (SqlException ol)
               {
                   MessageBox.Show(ol.ToString());
               }
            }

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
        
    }

}


