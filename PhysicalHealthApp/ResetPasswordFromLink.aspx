<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="ResetPasswordFromLink.aspx.cs" Inherits="PhysicalHealthApp.ResetPasswordFromLink" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">

        <div class="row" style="margin-top: 40px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 login-container">

                <div class="login-form">
                    <div>


                        <asp:Panel ID="pnlSuccess" runat="server">
                            <div class="alert alert-success">
                                <h3>Thank you, please reset your password below. </h3>
                                <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>
                            </div>

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

                            <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Reset Password" OnClick="btnResetPassword_Click" />

                        </asp:Panel>

                        <asp:Panel ID="pnlFailed" runat="server">
                            <div class="alert alert-danger">
                                <h3>Sorry</h3>
                                Invalid Confirmation Code, please ckeck and try again
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlResetWorked" runat="server">
                            <div class="alert alert-success">
                                <h3>Password reset successfully </h3>
                                You can now login using your new password.
                            </div>
                        </asp:Panel>


                        <asp:HiddenField ID="hdnCode" runat="server" />

                        <div class="form-links">
                            
                        </div>
                    </div>
                </div>


            </div>

            <div class="col-md-4">
            </div>


        </div>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-4"></div>

            <div class="col-md-4">
                <a class="btn btn-default" href="Login.aspx">Click here to login</a>
            </div>

            <div class="col-md-4"></div>
        </div>







    </div>
</asp:Content>


