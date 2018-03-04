<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PhysicalHealthApp.Register" %>

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
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Register</h2>
                        </div>


                        <asp:Panel id="fgUserType" runat="server" class="form-group">
                            <label class="control-label" for="ddlUserType">Do you want to register as a patient or as a clinician?</label>
                            <asp:Label ID="errUserType" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="Patient" Text="I want to register as a patient"></asp:ListItem>
                                <asp:ListItem Value="Clinician" Text="I want to register as a clinician"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>


                        <asp:Panel id="fgMatchedOrganisation" runat="server" class="form-group">
                            <asp:Label ID="lblMatchedOrganisation" runat="server" CssClass="control-label" for="ddlMatchedOrganisation" Text="Which organisation do you attend?" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errMatchedOrganisation" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlMatchedOrganisation" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="Somewhere Mental Health and Social Care Trust" Text="Somewhere Mental Health and Social Care Trust"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>

                        <asp:Panel id="fgMatchedClinician" runat="server" class="form-group">
                            <asp:Label ID="lblMatchedClinician" runat="server" CssClass="control-label" for="ddlMatchedClinician" Text="Please select your clinician" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errMatchedClinician" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlMatchedClinician" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="Dr Test" Text="Dr Test"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>

                        <hr />

                        <asp:Panel id="fgFirstName" runat="server" class="form-group">
                            <label class="control-label" for="txtFirstName">Please enter your first name</label>
                            <asp:Label ID="errFirstName" runat="server"></asp:Label>
                            <asp:TextBox ID="txtFirstName" runat="server" placeholder="Forename" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel id="fgLastName" runat="server" class="form-group">
                            <label class="control-label" for="txtLastName">Please enter your last name</label>
                            <asp:Label ID="errLastName" runat="server"></asp:Label>
                            <asp:TextBox ID="txtLastName" runat="server" placeholder="Surname" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>


                        <asp:Panel id="fgDOB" runat="server" class="form-group">
                            <label class="control-label" for="txtDOB">Please enter your date of birth</label>
                            <asp:Label ID="errDOB" runat="server"></asp:Label>
                            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control input-lg" TextMode="Date"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel id="fgtxtNHSNo" runat="server" class="form-group">
                            <label class="control-label" for="txtLastName">Please enter your NHS Number if you know it</label>
                            <asp:Label ID="errtxtNHSNo" runat="server"></asp:Label>
                            <asp:TextBox ID="txtNHSNo" runat="server" placeholder="NHSNo" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel id="fgGMCCode" runat="server" class="form-group">
                            <label class="control-label" for="txtGMCCode">Please enter your GMC Number</label>
                            <asp:Label ID="errGMCCode" runat="server"></asp:Label>
                            <asp:TextBox ID="txtGMCCode" runat="server" placeholder="GMC Number" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <hr />

                        <asp:Panel id="fgtxtEmail" runat="server" class="form-group">
                            <label class="control-label" for="txtEmail">Please enter your email address</label>
                            <asp:Label ID="errEmail" runat="server"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel id="fgPassword" runat="server" class="form-group">
                            <label class="control-label" for="txtPassword">Please enter a password</label>
                            <asp:Label ID="errPassword" runat="server"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" CssClass="form-control input-lg" TextMode="Password"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel id="fgConfirmPassword" runat="server" class="form-group">
                            <label class="control-label" for="txtConfirmPassword">Please confirm your password</label>
                            <asp:Label ID="errConfirmPassword" runat="server"></asp:Label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" CssClass="form-control input-lg" TextMode="Password"></asp:TextBox>
                        </asp:Panel>

                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Register" />
                        <br />
                        <div>
                            <a href="login.aspx">Return to login page</a>
                        </div>

                    </div>

                    <div class="form-links">
                        <br />
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>


        </div>





    </div>

</asp:Content>
