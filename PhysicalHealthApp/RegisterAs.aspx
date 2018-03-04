<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="RegisterAs.aspx.cs" Inherits="PhysicalHealthApp.RegisterAs" %>

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
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Register - Step 1</h2>
                        </div>


                        <br />

                        <asp:LinkButton ID="btnRegisterAsPatient" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="I want to register as a patient" OnClick="btnRegisterAsPatient_Click"></asp:LinkButton>
                        <br />
                        <asp:LinkButton ID="btnRegisterAsClinician" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="I want to register as a clinician" OnClick="btnRegisterAsClinician_Click"></asp:LinkButton>
                        

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
                <a class="btn btn-default" href="login.aspx">< Return to login page</a>
            </div>
            <div class="col-md-4"></div>
        </div>


    </div>

</asp:Content>

