<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="RegisterAsPatient.aspx.cs" Inherits="PhysicalHealthApp.RegisterAsPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- Modal -->
    <div class="modal fade" id="tncModal" tabindex="-1" role="dialog" aria-labelledby="tncModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="tncModalLabel">Terms and Conditions</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblTermsAndConditions" runat="server"></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div id="page-wrapper">

        


        <div class="row" style="margin-top: 40px;">
            <div class="col-md-4"></div>

            <div class="col-md-4 login-container">

                <div class="login-form">
                    <div>

                        <div style="text-align: center;">
                            <h2 style="color: #2a9fd6; font-weight: bolder;">Register - Step 2</h2>
                            <asp:Label ID="lblError" runat="server" CssClass="contentAlertDanger"></asp:Label>
                        </div>


                        <asp:Panel ID="fgUserType" runat="server" class="form-group">
                            <label class="control-label" for="ddlUserType"></label>
                            <asp:Label ID="errUserType" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="Patient" Text="I want to register as a patient"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>


                        <asp:Panel ID="fgMatchedOrganisation" runat="server" class="form-group">
                            <asp:Label ID="lblMatchedOrganisation" runat="server" CssClass="control-label" for="ddlMatchedOrganisation" Text="Which organisation do you attend?" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errMatchedOrganisation" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlMatchedOrganisation" runat="server" CssClass="form-control input-lg" AutoPostBack="true" OnSelectedIndexChanged="ddlMatchedOrganisation_SelectedIndexChanged">
                                <asp:ListItem Value="1" Text="One"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Two"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>

                        <asp:Panel ID="fgMatchedClinician" runat="server" class="form-group">
                            <asp:Label ID="lblMatchedClinician" runat="server" CssClass="control-label" for="ddlMatchedClinician" Text="Please select your clinician" Font-Bold="true"></asp:Label>
                            <asp:Label ID="errMatchedClinician" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlMatchedClinician" runat="server" CssClass="form-control input-lg">
                                <asp:ListItem Value="1" Text="One"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Two"></asp:ListItem>
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


                        <asp:Panel ID="fgDOB" runat="server" class="form-group">
                            <label class="control-label" for="txtDOB">Please enter your date of birth</label>
                            <asp:Label ID="errDOB" runat="server"></asp:Label>
                            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control input-lg" TextMode="Date"></asp:TextBox>
                        </asp:Panel>

                        <asp:Panel ID="fgtxtNHSNo" runat="server" class="form-group">
                            <label class="control-label" for="txtLastName">Please enter your NHS Number if you know it</label>
                            <asp:Label ID="errtxtNHSNo" runat="server"></asp:Label>
                            <asp:TextBox ID="txtNHSNo" runat="server" placeholder="NHSNo" CssClass="form-control input-lg"></asp:TextBox>
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


                        <asp:Panel ID="fgTnCs" runat="server" class="form-group">
                             <label class="control-label" for="chkAcceptTnCs" style="font-size: 2em;">
                                    Terms and conditions                                                                   
                            </label>
                            <button type="button" class="btn btn-block btn-default pull-right" data-toggle="modal" data-target="#tncModal">View Terms and Conditions</button>
                            <br /><br />
                            <asp:Label ID="lblTnCs" runat="server"></asp:Label>
                            <asp:CheckBox ID="chkAcceptTnCs" runat="server" />
                            I accept the terms and conditions
                        </asp:Panel>

                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-lg btn-primary btn-block" Text="Register" OnClick="btnRegister_Click" />      
                        
                        <br />

                        <div id="divThankYou" runat="server" class="alert alert-success">
                            <h3>Thank you</h3>
                            Confirmation Email Sent Successfully
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

                    </div>

                    <div class="form-links">
                        <br />
                    </div>
                </div>
            </div>

            <div class="col-md-4"></div>

             <asp:HiddenField ID="hdnEmail" runat="server" />   

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
