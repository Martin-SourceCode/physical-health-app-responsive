<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="RegistrationThankYou.aspx.cs" Inherits="PhysicalHealthApp.RegistrationThankYou" %>

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
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Thank you for Registering</h2>
                        </div>


                        <div style="text-align: center;">
                            <h2>Please check your email for a link to confirm your email address</h2>
                        </div>

                        <div style="text-align: center;">
                            <h2>Your account will also need to be authorised before you can sign in. An email has been sent to your <asp:Label ID="lblAccountAdministrator" runat="server" Text="Clinician"></asp:Label> asking them to authorise your account</h2>
                        </div>

                        <br />

                        <div style="text-align: center;">
                            <a href="login.aspx" style="font-size:2em;">Return to login page</a>
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
