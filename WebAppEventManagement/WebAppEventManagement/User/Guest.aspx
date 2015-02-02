<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  Theme="Skin1" CodeBehind="Guest.aspx.cs" Inherits="WebAppEventManagement.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Guests</h2>
    <asp:Panel ID="Panel1" runat="server">
        <asp:Label ID="LabelEvName" runat="server" Text="Event:"></asp:Label>
        <asp:TextBox ID="TextBoxEvName" runat="server" style="margin-left: 96px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="LabelFName" runat="server" Text="Guest First Name:"></asp:Label>
        <asp:TextBox ID="TextBoxFname" runat="server" style="margin-left: 26px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="LabelLName" runat="server" Text="Guest Last Name:"></asp:Label>
        <asp:TextBox ID="TextBoxLName" runat="server" style="margin-left: 25px"></asp:TextBox>
         <br />
        <br />
        <asp:Label ID="LabelEmail" runat="server" Text="Guest Email:"></asp:Label>
        <asp:TextBox ID="TextBoxEmail" runat="server" style="margin-left: 55px" 
            Height="22px"></asp:TextBox>
          <br />
          <br />
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" 
            style="margin-left: 123px" onclick="ButtonSearch_Click" 
             />
        <asp:Button ID="ButtonClear" runat="server" Text="Clear" 
            style="margin-left: 29px" Width="42px" onclick="ButtonClear_Click" />
         <br />
          <asp:Label ID="lblErr" runat="server" Text="Err"></asp:Label>
          <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="EventName" HeaderText="EventName" 
                    SortExpression="EventName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="GuestFirstName" HeaderText="GuestFirstName" 
                    SortExpression="GuestFirstName" />
                <asp:BoundField DataField="GuestLastName" HeaderText="GuestLastName" 
                    SortExpression="GuestLastName" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WebAppEventManagementConnectionString %>" 
            SelectCommand="SELECT [Email], [GuestFirstName], [GuestLastName], [EventName] FROM [Guests@Events]"></asp:SqlDataSource>
        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px">
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
    </asp:Panel>
</asp:Content>
