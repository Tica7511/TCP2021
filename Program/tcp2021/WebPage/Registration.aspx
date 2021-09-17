<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="WebPage_Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container margin15T">
    <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <div class="filetitlewrapper">
           <span class="filetitle font-size5">Online Training</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>

       <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL margin10TB">
           <a href="https://reurl.cc/En1Q3v" target="_blank">
               <img alt="registerB" src="<%= ResolveUrl("~/images/registerB.jpg") %>" class="img-responsive imgcenter" />
           </a>
           <div class="font-bold font-size3 margin5T">2021 APEC Medical Devices Regulatory Science Center of Excellence Workshop</div>
           <div class="margin5T font-size3">

               <div class="BoxRadiusB BoxBorderDa padding10ALL IconCc font-bold margin10T">
                   There is no registration fee for participating in the workshop.
               </div>

           </div>
       </div>

       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
    </div>
</asp:Content>

