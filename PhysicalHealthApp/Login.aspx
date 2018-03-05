<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PhysicalHealthApp.Login" %>

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
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Login</h2>
                        </div>

                        <asp:Panel ID="fgtxtEmail" runat="server" CssClass="form-group">
                            <label class="control-label" for="txtEmail">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="form-control input-lg"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgtxtPassword" runat="server" CssClass="form-group">
                            <label class="control-label" for="txtPassword">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" CssClass="form-control input-lg" TextMode="Password"></asp:TextBox>
                        </asp:Panel>

                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Sign In" OnClick="btnLogin_Click" />


                        <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>

                        <asp:Button ID="btnResendValidationEmail" runat="server" Text="Resend Validation Email" CssClass="btn btn-block btn-success" onclick="btnResendValidationEmail_Click"/>

                        <br />

                        <div id="divThankYou" runat="server" class="alert alert-success">
                            <h3>Thank you</h3>
                             Validation Email Sent Again
                        </div>

                        <div id="divError" runat="server" class="alert alert-danger">
                            <h3>Error</h3>
                            Sorry, something went wrong sending the email.
                            <br />
                            <br />
                            Details:
                            <br />
                            <br />
                            <asp:Label ID="lblEmailError" runat="server"></asp:Label>
                        </div>

                        <div class="form-links">
                            <br />
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-md-4">
            </div>

            <asp:HiddenField ID="hdnEmail" runat="server" />   

        </div>


        <div class="row" style="margin-top: 15px;">
            <div class="col-md-4"></div>

            <div class="col-md-4">
                <div class="login-form">
                    <div>
                        <a class="btn btn-default" href="RegisterAs.aspx">Register</a> <a class="btn btn-default pull-right" href="ResetPassword.aspx">Reset password</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>
        </div>




        <div class="row" style="margin-top: 25px;">
            <div class="col-md-4"></div>
            <div class="col-md-4">Project Sponsors</div>
            <div class="col-md-4"></div>
        </div>


        <div class="row" style="margin-top: 5px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 logo-container">

                <div class="login-form">
                    <div style="text-align: center;">
                        <img src="img/Janssen.png" style="max-width: 99%;" />
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>
        </div>

        <div class="row" style="margin-top: 5px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 logo-container">

                <div class="login-form">
                    <div style="text-align: center;">
                        <img src="img/NHS-Digital-logo.png" style="max-width: 99%;" />
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>
        </div>

        <div class="row" style="margin-top: 10px;">
            <div class="col-md-4"></div>

            <div class="col-md-4">

                <div class="login-form">
                    <div>
                        Powered by <a href="http://www.interneuron.org" target="_blank">Interneuron CIC</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>
        </div>

        <div class="hidden">
            <asp:Label ID="lblRedirect" runat="server"></asp:Label>
        </div>


    </div>
</asp:Content>
