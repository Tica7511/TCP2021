<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="newsview.aspx.cs" Inherits="WebPage_newsview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container marT5v margin10B">

   
   <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->


       <div class="paddingMVRL">

           <div class="margin10T BoxBgOb BoxRadiusB padding10ALL margin10B">


               <div class="twocol font-white">
                   <div class="left">
                       <div class="opa6"><asp:Label ID="nDate" runat="server"></asp:Label></div>
                       <div class="font-size4 font-white"><asp:Label ID="nTitle" runat="server"></asp:Label></div>
                   </div>
                   <div class="right">

                   </div>
               </div>

               <div class="lineheight03 font-white opa8 margin20T">
                   <asp:Label ID="nContent" runat="server"></asp:Label>
               </div>

           </div><!-- BoxBorderSa -->

       </div><!-- paddingMVRL -->
       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
   
   </div><!-- conainer -->
</asp:Content>

