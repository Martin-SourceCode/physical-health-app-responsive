<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="RegisterAsSuperUser.aspx.cs" Inherits="PhysicalHealthApp.RegisterAsSuperUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">

        

        <div class="row" style="margin-top: 40px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 login-container">

                <div class="login-form">
                    <div>

                        <div style="text-align: center;">
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Create super user</h2>
                            <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>
                        </div>


                        <asp:Panel ID="fgUserType" runat="server" class="form-group">
                            <label class="control-label" for="ddlUserType"></label>
                            <asp:Label ID="errUserType" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="Super User" Text="I want to register as a Super User"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>



                        <hr />

                        <asp:Panel ID="fgFirstName" runat="server" class="form-group">
                            <label class="control-label" for="txtFirstName">Please enter your first name</label>
                            <asp:Label ID="errFirstName" runat="server"></asp:Label>
                            <asp:TextBox ID="txtFirstName" runat="server" placeholder="Forename" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgLastName" runat="server" class="form-group">
                            <label class="control-label" for="txtLastName">Please enter your last name</label>
                            <asp:Label ID="errLastName" runat="server"></asp:Label>
                            <asp:TextBox ID="txtLastName" runat="server" placeholder="Surname" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <hr />

                        <asp:Panel ID="fgEmail" runat="server" class="form-group">
                            <label class="control-label" for="txtEmail">Please enter your email address</label>
                            <asp:Label ID="errEmail" runat="server"></asp:Label>
                            <asp:TextBox ID="txtRegistrationEmail" runat="server" placeholder="Email" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgPassword" runat="server" class="form-group">
                            <label class="control-label" for="txtPassword">Please enter a password</label>
                            <asp:Label ID="errPassword" runat="server"></asp:Label>
                            <asp:TextBox ID="txtRegistrationPassword" runat="server" placeholder="Password" CssClass="form-control input-lg" TextMode="Password"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgConfirmPassword" runat="server" class="form-group">
                            <label class="control-label" for="txtConfirmPassword">Please confirm your password</label>
                            <asp:Label ID="errConfirmPassword" runat="server"></asp:Label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" CssClass="form-control input-lg" TextMode="Password"></asp:TextBox>
                        </asp:Panel>

                        <hr />
                        <h3>If you want to register as a clinician please complete the fields below:</h3>
                        <asp:Panel ID="fgGMCCode" runat="server" class="form-group">
                            <label class="control-label" for="txtGMCCode">Please enter your GMC Number</label>
                            <asp:Label ID="errGMCCode" runat="server"></asp:Label>
                            <asp:TextBox ID="txtGMCCode" runat="server" placeholder="GMC Number" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgMatchedOrganisation" runat="server" class="form-group">
                            <asp:Label ID="lblMatchedOrganisation" runat="server" CssClass="control-label" for="ddlMatchedOrganisation" Text="Which organisation do you want to register for?" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errMatchedOrganisation" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlMatchedOrganisation" runat="server" CssClass="form-control input-lg">
                            </asp:DropDownList>
                        </asp:Panel>

                        <hr />

                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Register" OnClick="btnRegister_Click" />
                        
                    </div>

                    <div class="form-links">
                        <br />
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>


        </div>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <a class="btn btn-default" href="RegisterAs.aspx">< Back</a>
            </div>
            <div class="col-md-4"></div>
        </div>



    </div>

</asp:Content>


