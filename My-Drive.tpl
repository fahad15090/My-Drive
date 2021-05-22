[api level]
2

[+special:strings]
_use_font=1
_player=0
_time_format=0

[+special:alias|cache]
fallback={.if|$1|$1|$2.}
get-common-html={.replace|@head@|$1|@body@|$2|{.$common-html.}.}
mm-dd-yyyy={.time|format={.fallback|{.!_time_format.}|mm/dd/yyyy.}|when=%item-modified%.}
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result={.!Bad session.}.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|"|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes


[common-html]
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#000000"/>
    <meta name="description" content="{.!My Drive..}" />
    <link rel="stylesheet" href="/~takeback-general.css" defer />
    {.if|{.!_use_font.}|<link rel="stylesheet" href="/~Roboto-font.css" defer />.}
    @head@
    <script>
        window.HFS = {
            sid: '{.cookie|HFS_SID_.}',
            folder: '%folder%',
            encodedFolder: '%encoded-folder%',
            can_delete: '{.get|can delete.}',
            can_mkdir: '{.can mkdir.}',
            can_comment: '{.can comment.}',
            can_rename: '{.can rename.}',
            can_move: '{.can move.}'
        }
    </script>
</head>
<body>
    <section id="dialog" style="opacity: 0;"></section>
    <section id="tooltip" style="display: none;"></section>
    <script src="/~takeback-general.js"></script>
    @body@
</body>
</html>

[]
{.get-common-html|
    <title>My Drive-%folder%</title>
    <link rel="stylesheet" href="/~takeback-filelist.css" defer />
|
    <!-- Header, Nav, Notice -->
    <nav class="nav">
        <div class="logo">My Drive</div>
        <input type="checkbox" id="click">
        <label for="click" class="menu-btn">
          <i class="fas fa-bars"></i>
        </label>
        <div class="s-div">
            <input type="text" name="name" class="search-control" placeholder="Search">
            <button type="submit"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28"><path fill="none" d="M0 0h24v24H0z"/><path d="M18.031 16.617l4.283 4.282-1.415 1.415-4.282-4.283A8.96 8.96 0 0 1 11 20c-4.968 0-9-4.032-9-9s4.032-9 9-9 9 4.032 9 9a8.96 8.96 0 0 1-1.969 5.617zm-2.006-.742A6.977 6.977 0 0 0 18 11c0-3.868-3.133-7-7-7-3.868 0-7 3.132-7 7 0 3.867 3.132 7 7 7a6.977 6.977 0 0 0 4.875-1.975l.15-.15z"/></svg></button>
        </div>
    <div class="login-con">
        <!-- <a href="/~login#%encoded-folder%">
         <svg class="user" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 2c5.52 0 10 4.48 10 10s-4.48 10-10 10S2 17.52 2 12 6.48 2 12 2zM6.023 15.416C7.491 17.606 9.695 19 12.16 19c2.464 0 4.669-1.393 6.136-3.584A8.968 8.968 0 0 0 12.16 13a8.968 8.968 0 0 0-6.137 2.416zM12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" fill="#fff"/></svg>
         %user%</a>-->
            <span class="login-con">
                <span><svg class="user" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 2c5.52 0 10 4.48 10 10s-4.48 10-10 10S2 17.52 2 12 6.48 2 12 2zM6.023 15.416C7.491 17.606 9.695 19 12.16 19c2.464 0 4.669-1.393 6.136-3.584A8.968 8.968 0 0 0 12.16 13a8.968 8.968 0 0 0-6.137 2.416zM12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" fill="#fff"/></svg>
 <p>%user%</p></span>
                {.if|%user%|
                    <a class="login-l" href="/~login#%encoded-folder%"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 14v8H4a8 8 0 0 1 8-8zm0-1c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6zm2.595 5.812a3.51 3.51 0 0 1 0-1.623l-.992-.573 1-1.732.992.573A3.496 3.496 0 0 1 17 14.645V13.5h2v1.145c.532.158 1.012.44 1.405.812l.992-.573 1 1.732-.992.573a3.51 3.51 0 0 1 0 1.622l.992.573-1 1.732-.992-.573a3.496 3.496 0 0 1-1.405.812V22.5h-2v-1.145a3.496 3.496 0 0 1-1.405-.812l-.992.573-1-1.732.992-.572zM18 17a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" fill="#fff"/></svg></a>|
                    <a href="/~login#%encoded-folder%">{.!Login.}</a>
                .}
            </span>
    </div>
    </nav>

    %files%
.}
    <script>
        function gridView() {
            var grid = document.getElementById("file-v-g");
            var list = document.getElementById("file-v-l");
            if (grid.style.display == "none") {
                grid.style.display = "block",
                    list.style.display = "none"
            } else {
                grid.style.display = "none",
                    list.style.display = "block"
            }
        }
    </script>
    <script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function sortFun() {
  document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>
[files]
<!-- Filelist -->
     <section class="additional-panel">
            <div class="file-o">
            <div class="file-t">
            <span>
                {.replace|<a href="/"></a>|<a href="/"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 20a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-9H1l10.327-9.388a1 1 0 0 1 1.346 0L23 11h-3v9zm-8-3l3.359-3.359a2.25 2.25 0 1 0-3.182-3.182l-.177.177-.177-.177a2.25 2.25 0 1 0-3.182 3.182L12 17z" fill="#fff" /></svg></a>|{.breadcrumbs|<a href="%bread-url%">%bread-name%</a>/.}.}
            </span>
            </div>
            <div class="file-p-c">
                <a id="showthumb" class="invert" href="javascript:" data-tooltip="{.!Show thumbnails of photos.}" >
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M5 11.1l2-2 5.5 5.5 3.5-3.5 3 3V5H5v6.1zm0 2.829V19h3.1l2.986-2.985L7 11.929l-2 2zM10.929 19H19v-2.071l-3-3L10.929 19zM4 3h16a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm11.5 7a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z" fill="#fff"/></svg>
                </a>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" href="./~folder.tar" data-tooltip="{.!Save files in this folder to an archive.}"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 5a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2H16v2h2V5h3zm-3 8h-2v2h-2v3h4v-5zm-2-2h-2v2h2v-2zm2-2h-2v2h2V9zm-2-2h-2v2h2V7z" fill="rgba(255,255,255,1)"/></svg>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M17 4h5v2h-2v15a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V6H2V4h5V2h10v2zM9 9v8h2V9H9zm4 0v8h2V9h-2z" fill="#fff"/></svg>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M13.576 17.271l-5.11-2.787a3.5 3.5 0 1 1 0-4.968l5.11-2.787a3.5 3.5 0 1 1 .958 1.755l-5.11 2.787a3.514 3.514 0 0 1 0 1.458l5.11 2.787a3.5 3.5 0 1 1-.958 1.755z" fill="#fff" /></svg>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M13 10h5l-6 6-6-6h5V3h2v7zm-9 9h16v-7h2v8a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-8h2v7z" fill="#fff"/></svg>
                {.if|{.can mkdir.}|
                <svg title="{.!New folder.}" id='newfolderBtn' onclick='ask(this.innerHTML, "text", name=> ajax("mkdir", { name:name }))' xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2zM11 12H8v2h3v3h2v-3h3v-2h-3V9h-2v3z" fill="#fff"/></svg>
                .}
                <svg id="file-v-g" class="file-v-g" onclick="gridView()" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M14 10v4h-4v-4h4zm2 0h5v4h-5v-4zm-2 11h-4v-5h4v5zm2 0v-5h5v4a1 1 0 0 1-1 1h-4zM14 3v5h-4V3h4zm2 0h4a1 1 0 0 1 1 1v4h-5V3zm-8 7v4H3v-4h5zm0 11H4a1 1 0 0 1-1-1v-4h5v5zM8 3v5H3V4a1 1 0 0 1 1-1h4z" fill="#fff"/></svg>
                <svg id="file-v-l" class="file-v-l" onclick="gridView()" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M11 4h10v2H11V4zm0 4h6v2h-6V8zm0 6h10v2H11v-2zm0 4h6v2h-6v-2zM3 4h6v6H3V4zm2 2v2h2V6H5zm-2 8h6v6H3v-6zm2 2v2h2v-2H5z" fill="#fff"/></svg>
             {.if|{.get|can upload.}|
                    <a class="invert" href="./~upload" data-tooltip="{.!Upload some files to this folder.}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 19h18v2H3v-2zM13 5.828V17h-2V5.828L4.929 11.9l-1.414-1.414L12 2l8.485 8.485-1.414 1.414L13 5.83z" fill="rgba(255,255,255,1)"/></svg></a>
            .}    
                </div>

            </div>
        </section>
        <section class="assigner" id="assigner">
            <div class="file-n">
            <a href="javascript:window.history.go(-1)" ><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10.828 12l4.95 4.95-1.414 1.414L8 12l6.364-6.364 1.414 1.414z" fill="rgba(0,0,0,1)"/></svg></a>
                <p>Name</p>
        <div class="dropdown">
            <svg onclick="sortFun()" class="dropbtn" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 13.172l4.95-4.95 1.414 1.414L12 16 5.636 9.636 7.05 8.222z" fill="#000"/></svg>
            <div id="myDropdown" class="dropdown-content">
            <a class="invert" href="./?sort=e" data-tooltip="{.!Sort by extension.}">Sort by extension</a>
            <a class="invert" href="./?sort=n" data-tooltip="{.!Sort by name.}">Sort by name</a>
            </div>
        </div>  
            </div>
            <div class="file-m">
                    <a class="invert" href="./?sort=!t" data-tooltip="{.!Click to sort files by time.} [ {.!Format:.}mm/dd/yyyy ]">
                     <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M13 16.172l5.364-5.364 1.414 1.414L12 20l-7.778-7.778 1.414-1.414L11 16.172V4h2v12.172z"/></svg>   
                    </a><p>Last Modified</p>
            </div>
            <div class="file-s">
                <a class="invert" href="./?sort=s" data-tooltip="{.!Click to sort files by size.}">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M13 16.172l5.364-5.364 1.414 1.414L12 20l-7.778-7.778 1.414-1.414L11 16.172V4h2v12.172z"/></svg>
                </a><p>Size</p>
            </div>
        </section>
<section class="part1">

    <section id="files-list">
            %list%
    </section>
</section>
<!-- Footer -->
<!--<section class="part2">
    <p>
        <a href="./~folder.tar" data-tooltip="{.!Save files in this folder to an archive.}">[ {.!Archive.} ]</a>
    </p>
    <div class="blank"></div>
</section>-->
<!-- Dashboard -->
<section class="part3">

    <div class="right">
        <div id="preview" style="display: none;">
            <a href="javascript:" data-preview="close" class="close">
                <span>[X]</span>
            </a>
            <div class="title">
                <span class="arrow"></span>
                <span data-preview="title"></span>
            </div>
            <div data-preview="menu"></div>
            <hr />
            <div data-preview="content"></div>
        </div>
    </div>
</section>
<section class="slideshow" style="display: none;">
    <img src="" alt="" />
    <img src="" alt="" />
</section>
<script src="/~takeback-filelist.js" defer></script>

[nofiles]
<p>
    {.if|{.length|{.?search.}.}|
        {.!No search results.}|
        {.!Empty folder.}
    .}
</p>

[file]
<div class="file">
    <div class="file-main">
    <div class="file-img"></div>
    <section class="file-link" style="margin: auto 0;">
            <a href="%item-url%">
{.switch|%item-ext%|,
|html|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 18.178l4.62-1.256.623-6.778H9.026L8.822 7.89h8.626l.227-2.211H6.325l.636 6.678h7.82l-.261 2.866-2.52.667-2.52-.667-.158-1.844h-2.27l.329 3.544L12 18.178zM3 2h18l-1.623 18L12 22l-7.377-2L3 2z" fill="rgba(255,255,255,1)"/></svg>
|htm|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 18.178l4.62-1.256.623-6.778H9.026L8.822 7.89h8.626l.227-2.211H6.325l.636 6.678h7.82l-.261 2.866-2.52.667-2.52-.667-.158-1.844h-2.27l.329 3.544L12 18.178zM3 2h18l-1.623 18L12 22l-7.377-2L3 2z" fill="rgba(255,255,255,1)"/></svg>
|url|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 18.178l4.62-1.256.623-6.778H9.026L8.822 7.89h8.626l.227-2.211H6.325l.636 6.678h7.82l-.261 2.866-2.52.667-2.52-.667-.158-1.844h-2.27l.329 3.544L12 18.178zM3 2h18l-1.623 18L12 22l-7.377-2L3 2z" fill="rgba(255,255,255,1)"/></svg>
|xhtml|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 18.178l4.62-1.256.623-6.778H9.026L8.822 7.89h8.626l.227-2.211H6.325l.636 6.678h7.82l-.261 2.866-2.52.667-2.52-.667-.158-1.844h-2.27l.329 3.544L12 18.178zM3 2h18l-1.623 18L12 22l-7.377-2L3 2z" fill="rgba(255,255,255,1)"/></svg>

|bat|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm9 12v2h6v-2h-6zm-3.586-3l-2.828 2.828L7 16.243 11.243 12 7 7.757 5.586 9.172 8.414 12z" fill="rgba(255,255,255,1)"/></svg>
|bak|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm9 12v2h6v-2h-6zm-3.586-3l-2.828 2.828L7 16.243 11.243 12 7 7.757 5.586 9.172 8.414 12z" fill="rgba(255,255,255,1)"/></svg>
|dat|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm9 12v2h6v-2h-6zm-3.586-3l-2.828 2.828L7 16.243 11.243 12 7 7.757 5.586 9.172 8.414 12z" fill="rgba(255,255,255,1)"/></svg>
|ini|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 5v2h2V7h-2zm0 4v6h2v-6h-2z" fill="rgba(255,255,255,1)"/></svg>
|sys|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zM8.595 12.812l-.992.572 1 1.732.992-.573c.393.372.873.654 1.405.812V16.5h2v-1.145a3.496 3.496 0 0 0 1.405-.812l.992.573 1-1.732-.992-.573a3.51 3.51 0 0 0 0-1.622l.992-.573-1-1.732-.992.573A3.496 3.496 0 0 0 13 8.645V7.5h-2v1.145a3.496 3.496 0 0 0-1.405.812l-.992-.573-1 1.732.992.573a3.51 3.51 0 0 0 0 1.623zM12 13.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z" fill="rgba(255,255,255,1)"/></svg>
|vfs|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zM8.595 12.812l-.992.572 1 1.732.992-.573c.393.372.873.654 1.405.812V16.5h2v-1.145a3.496 3.496 0 0 0 1.405-.812l.992.573 1-1.732-.992-.573a3.51 3.51 0 0 0 0-1.622l.992-.573-1-1.732-.992.573A3.496 3.496 0 0 0 13 8.645V7.5h-2v1.145a3.496 3.496 0 0 0-1.405.812l-.992-.573-1 1.732.992.573a3.51 3.51 0 0 0 0 1.623zM12 13.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z" fill="rgba(255,255,255,1)"/></svg>
|exe|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|/|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2z" fill="rgba(255,255,255,1)"/></svg>
|dll|
|jar|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|msi|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|py|
|com|
|pl|
|apk|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|inf|
|log|
|cfg|
|ink|
|tmp|
|cab|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>

|as|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|aspx|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|css|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M5 3l-.65 3.34h13.59L17.5 8.5H3.92l-.66 3.33h13.59l-.76 3.81-5.48 1.81-4.75-1.81.33-1.64H2.85l-.79 4 7.85 3 9.05-3 1.2-6.03.24-1.21L21.94 3z" fill="rgba(255,255,255,1)"/></svg>
|js|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|txt|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 9v11.993A1 1 0 0 1 20.007 22H3.993A.993.993 0 0 1 3 21.008V2.992C3 2.455 3.447 2 3.998 2H14v6a1 1 0 0 0 1 1h6zm0-2h-5V2.003L21 7zM8 7v2h3V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z" fill="rgba(255,255,255,1)"/></svg>
|php|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|tpl|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|xml|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm1.657 10L14.12 8.464 12.707 9.88 14.828 12l-2.12 2.121 1.413 1.415L17.657 12zM6.343 12l3.536 3.536 1.414-1.415L9.172 12l2.12-2.121L9.88 8.464 6.343 12z" fill="rgba(255,255,255,1)"/></svg>
|part|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 14l4 2.5 3-3.5 3 4 2-2.5 3 .5-3-3-2 2.5-3-5-3.5 3.75L3 10V2.992C3 2.455 3.447 2 3.998 2H14v6a1 1 0 0 0 1 1h6v11.993A1 1 0 0 1 20.007 22H3.993A.993.993 0 0 1 3 21.008V14zm18-7h-5V2.003L21 7z" fill="rgba(255,255,255,1)"/></svg>

|xls|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zm-6.8 9L13 8h-2.4L9 10.286 7.4 8H5l2.8 4L5 16h2.4L9 13.714 10.6 16H13l-2.8-4z" fill="rgba(255,255,255,1)"/></svg>
|xlsx|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zm-6.8 9L13 8h-2.4L9 10.286 7.4 8H5l2.8 4L5 16h2.4L9 13.714 10.6 16H13l-2.8-4z" fill="rgba(255,255,255,1)"/></svg>
|ppt|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zM2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM5 8v8h2v-2h6V8H5zm2 2h4v2H7v-2z" fill="rgba(255,255,255,1)"/></svg>
|pptx|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zM2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM5 8v8h2v-2h6V8H5zm2 2h4v2H7v-2z" fill="rgba(255,255,255,1)"/></svg>
|doc|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zM2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM11 8v4.989L9 11l-1.99 2L7 8H5v8h2l2-2 2 2h2V8h-2z" fill="rgba(255,255,255,1)"/></svg>
|docx|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M17 3h4a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1h-4V3zM2.859 2.877l12.57-1.795a.5.5 0 0 1 .571.495v20.846a.5.5 0 0 1-.57.495L2.858 21.123a1 1 0 0 1-.859-.99V3.867a1 1 0 0 1 .859-.99zM11 8v4.989L9 11l-1.99 2L7 8H5v8h2l2-2 2 2h2V8h-2z" fill="rgba(255,255,255,1)"/></svg>
|pdf|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M19 22H5a3 3 0 0 1-3-3V3a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v12h4v4a3 3 0 0 1-3 3zm-1-5v2a1 1 0 0 0 2 0v-2h-2zM6 7v2h8V7H6zm0 4v2h8v-2H6zm0 4v2h5v-2H6z" fill="rgba(255,255,255,1)"/></svg>

|otf|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 22H4a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1zM8 7v2h8V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z" fill="rgba(255,255,255,1)"/></svg>
|ttf|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 22H4a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1zM8 7v2h8V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z" fill="rgba(255,255,255,1)"/></svg>
|woff|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 22H4a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1zM8 7v2h8V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z" fill="rgba(255,255,255,1)"/></svg>
|woff2|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 22H4a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1zM8 7v2h8V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z" fill="rgba(255,255,255,1)"/></svg>

|jpg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 5H4v14l9.292-9.294a1 1 0 0 1 1.414 0L20 15.01V5zM2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM8 11a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" fill="rgba(255,255,255,1)"/></svg>
|jpeg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 5H4v14l9.292-9.294a1 1 0 0 1 1.414 0L20 15.01V5zM2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM8 11a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" fill="rgba(255,255,255,1)"/></svg>
|png|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 5H4v14l9.292-9.294a1 1 0 0 1 1.414 0L20 15.01V5zM2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM8 11a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" fill="rgba(255,255,255,1)"/></svg>
|gif|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 5H4v14l9.292-9.294a1 1 0 0 1 1.414 0L20 15.01V5zM2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM8 11a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" fill="rgba(255,255,255,1)"/></svg>
|ai|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 21l-4.762-8.73L15 6l8 15h-7zM8 10l6 11H2l6-11zM5.5 8a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" fill="rgba(255,255,255,1)"/></svg>
|bmp|
|ico|
|ps|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 21l-4.762-8.73L15 6l8 15h-7zM8 10l6 11H2l6-11zM5.5 8a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" fill="rgba(255,255,255,1)"/></svg>
|psd|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 21l-4.762-8.73L15 6l8 15h-7zM8 10l6 11H2l6-11zM5.5 8a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" fill="rgba(255,255,255,1)"/></svg>
|svg|
|tif|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 21l-4.762-8.73L15 6l8 15h-7zM8 10l6 11H2l6-11zM5.5 8a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" fill="rgba(255,255,255,1)"/></svg>
|tiff|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 21l-4.762-8.73L15 6l8 15h-7zM8 10l6 11H2l6-11zM5.5 8a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" fill="rgba(255,255,255,1)"/></svg>

|flv|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM4 5v2h2V5H4zm14 0v2h2V5h-2zM4 9v2h2V9H4zm14 0v2h2V9h-2zM4 13v2h2v-2H4zm14 0v2h2v-2h-2zM4 17v2h2v-2H4zm14 0v2h2v-2h-2z" fill="rgba(255,255,255,1)"/></svg>
|mp4|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zM4 5v2h2V5H4zm14 0v2h2V5h-2zM4 9v2h2V9H4zm14 0v2h2V9h-2zM4 13v2h2v-2H4zm14 0v2h2v-2h-2zM4 17v2h2v-2H4zm14 0v2h2v-2h-2z" fill="rgba(255,255,255,1)"/></svg>
|asf|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|mkv|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|divx|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|mov|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|mpg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|mpeg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|m4v|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|3g2|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>
|3gp|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M2 3.993A1 1 0 0 1 2.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 0 1-.992.993H2.992A.993.993 0 0 1 2 20.007V3.993zm8.622 4.422a.4.4 0 0 0-.622.332v6.506a.4.4 0 0 0 .622.332l4.879-3.252a.4.4 0 0 0 0-.666l-4.88-3.252z" fill="rgba(255,255,255,1)"/></svg>

|mp3|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|wma|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|wmv|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|aac|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|m4a|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|wav|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|avi|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>
|ogg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z" fill="rgba(255,255,255,1)"/></svg>


|zip|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z" fill="rgba(255,255,255,1)"/></svg>
|rar|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z" fill="rgba(255,255,255,1)"/></svg>
|7zip|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z" fill="rgba(255,255,255,1)"/></svg>
|tar|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z" fill="rgba(255,255,255,1)"/></svg>
|deb|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|pkg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|rpm|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|tar.gz|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z" fill="rgba(255,255,255,1)"/></svg>

|bin|
|dmg|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 3l2 4v13a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V7.004L4 3h16zm-8 7l-4 4h3v4h2v-4h3l-4-4zm6.764-5H5.236l-.999 2h15.527l-1-2z" fill="rgba(255,255,255,1)"/></svg>
|vcd|

|sql|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 9.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5zm-18 5c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3zm9-2.5c-4.97 0-9-2.015-9-4.5S7.03 3 12 3s9 2.015 9 4.5-4.03 4.5-9 4.5z" fill="rgba(255,255,255,1)"/></svg>
|csv|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M20 22H4a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1zM8 7v2h8V7H8zm0 4v2h8v-2H8zm0 4v2h5v-2H8z" fill="rgba(255,255,255,1)"/></svg>
|db|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 9.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5zm-18 5c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3zm9-2.5c-4.97 0-9-2.015-9-4.5S7.03 3 12 3s9 2.015 9 4.5-4.03 4.5-9 4.5z" fill="rgba(255,255,255,1)"/></svg>
|dbf|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 9.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5zm-18 5c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3zm9-2.5c-4.97 0-9-2.015-9-4.5S7.03 3 12 3s9 2.015 9 4.5-4.03 4.5-9 4.5z" fill="rgba(255,255,255,1)"/></svg>
|mdb|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M21 9.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5zm-18 5c0 2.485 4.03 4.5 9 4.5s9-2.015 9-4.5v3c0 2.485-4.03 4.5-9 4.5s-9-2.015-9-4.5v-3zm9-2.5c-4.97 0-9-2.015-9-4.5S7.03 3 12 3s9 2.015 9 4.5-4.03 4.5-9 4.5z" fill="rgba(255,255,255,1)"/></svg>
| {.comment| Default Icon, display either by extension, or if an extension does not exist, use the default image! .}
    {.if|{.filesize|/png/%item-ext%.png.}
        |<img src="/png/%item-ext%.png"/>
        |<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 13v2h2v-2h-2zm2-1.645A3.502 3.502 0 0 0 12 6.5a3.501 3.501 0 0 0-3.433 2.813l1.962.393A1.5 1.5 0 1 1 12 11.5a1 1 0 0 0-1 1V14h2v-.645z" fill="rgba(255,255,255,1)"/></svg>
    /if.}        
/switch.}<p>%item-name%</p></a></section>
    <section class="file-date" style="margin: auto 0;">{.mm-dd-yyyy.}</section>
    <section class="file-type" style="margin: auto 0;">%item-size%B</section>
    </div>
</div>

[folder]
<div class="folder">
    <div class="file-main">
    <div class="file-img"></div>
    <section class="file-link"><a href="%item-url%" style="margin: auto 0;"><p>%item-name%</p></a></section>
    <section class="file-date" style="margin: auto 0;">{.mm-dd-yyyy.}</section>
    <section class="file-type" style="margin: auto 0;">{.!folder.}</section>
    </div>
</div>

[link]
<div class="link">
    <div class="file-main">
    <section class="file-link"><a href="%item-url%" style="margin: auto 0;"><p>%item-name%</p></a></section>
    <section></section>
    <section>{.!link.}</section>
    </div>
</div>

[takeback-general.js|public|no log|cache]
// <script>
    class Helper {
        getFilename(path) {
            return decodeURIComponent(path.split('/').slice(-1)[0]);
        }
        getDirname(path) {
            return decodeURIComponent(path.split('/').slice(0, -1).join('/') + '/');
        }
        getPath(url) {
            return decodeURIComponent('/' + url.split('/').slice(3).join('/'));
        }
    }
    window.helper = new Helper();

    class Animator {
        constructor(selector) {
            if (typeof selector == 'string') {
                this.elements = document.querySelectorAll(selector);
            } else {
                this.elements = [selector];
            }
            this.FRAME = 1000 / 60;
            // Edit CSS for controlling how to animate
            this.classShow = 'animator-show';
            this.classHide = 'animator-hide';
        }
        hide(timeout = 200, callbackfn = () => undefined) {
            this.elements.forEach(element => {
                element.style.transition = `all ${timeout}ms`;
                setTimeout(() => {
                    element.classList.add(this.classHide);
                    element.classList.remove(this.classShow);
                }, this.FRAME);
                setTimeout(() => {
                    element.style.transition = '';
                    element.style.display = 'none';
                    callbackfn();
                }, timeout - 1);
            });
        }
        show(timeout = 200, callbackfn = () => undefined) {
            this.elements.forEach(element => {
                element.classList.add(this.classHide);
                element.style.transition = `all ${timeout}ms`;
                element.style.display = '';
                setTimeout(() => {
                    element.classList.remove(this.classHide);
                    element.classList.add(this.classShow);
                }, this.FRAME);
                setTimeout(() => {
                    element.style.transition = '';
                    element.style.display = '';
                    callbackfn();
                }, timeout);
            });
        }
    }
    window.$ = (x) => new Animator(x);

    class TooltipManager {
        constructor() {
            this.elemTooltip = document.getElementById('tooltip');
            document.querySelectorAll('*[data-tooltip]').forEach(element => {
                element.addEventListener('mouseover', event => this.show(element.getAttribute('data-tooltip')));
                element.addEventListener('mouseout', event => this.hide());
            });
        }
        show(message) {
            this.elemTooltip.innerText = message;
            $(this.elemTooltip).show();
        }
        hide() {
            $(this.elemTooltip).hide();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.tooltip_manager = new TooltipManager());

    class Dialog {
        constructor() {
            this.sectionDialog = document.getElementById('dialog');
            this.elemDialog = document.createElement('div');
            $(this.elemDialog).hide();
            this.elemDialog.classList.add('dialog');
            this.elemText = document.createElement('p');
            let hr = document.createElement('hr');
            this.elemActions = document.createElement('p');
            this.elemActions.style.display = 'flex';
            this.elemActions.style.justifyContent = 'space-around';
            this.elemDialog.appendChild(this.elemText);
            this.elemDialog.appendChild(hr);
            this.elemDialog.appendChild(this.elemActions);
            this.sectionDialog.appendChild(this.elemDialog);
            this.close();
        }
        clearActions() {
            this.elemActions.querySelectorAll('*').forEach(e => e.remove());
        }
        showDialog() {
            this.sectionDialog.style.top = '0';
            this.sectionDialog.style.opacity = '1';
            $(this.elemDialog).show();
        }
        close() {
            this.sectionDialog.style.opacity = '0';
            $(this.elemDialog).hide(undefined, () => this.sectionDialog.style.top = '200%');
        }
        alert(message, callbackfn = () => undefined) {
            function done() {
                this.close();
                callbackfn();
            }
            this.elemDialog.onkeyup = event => {
                if (event.key == 'Enter') done.bind(this)();
            };
            this.elemText.innerText = message;
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('ok-btn');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            this.showDialog();
        }
        confirm(message, callbackfn = () => undefined) {
            function done() {
                this.close();
                callbackfn();
            }
            this.elemDialog.onkeyup = event => {
                if (event.key == 'Enter') done.bind(this)();
            };
            this.elemText.innerText = message;
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('ok-btn');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            let cancel = document.createElement('a');
            cancel.innerText = '{.!Cancel.}';
            cancel.href = 'javascript:';
            cancel.classList.add('invert');
            cancel.addEventListener('click', event => {
                this.close();
            });
            this.elemActions.appendChild(cancel);
            this.showDialog();
        }
        prompt(message, callbackfn = (input) => input) {
            function done() {
                this.close();
                callbackfn(elemInput.value);
            }
            this.elemText.innerText = message;
            let elemInput = document.createElement('input');
            let br = document.createElement('br');
            elemInput.type = 'text';
            elemInput.classList.add('prompt-input');
            elemInput.addEventListener('keyup', event => {
                if (event.key == 'Enter') done.bind(this)();
            });
            this.elemText.appendChild(br);
            this.elemText.appendChild(elemInput);
            this.clearActions();
            let ok = document.createElement('a');
            ok.innerText = '{.!OK.}';
            ok.href = 'javascript:';
            ok.classList.add('invert');
            ok.addEventListener('click', done.bind(this));
            this.elemActions.appendChild(ok);
            let cancel = document.createElement('a');
            cancel.innerText = '{.!Cancel.}';
            cancel.href = 'javascript:';
            cancel.classList.add('invert');
            cancel.addEventListener('click', event => {
                this.close();
            });
            this.elemActions.appendChild(cancel);
            this.showDialog();
            elemInput.focus();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.dialog = new Dialog());
// </script>

[takeback-filelist.js|public|no log|cache]
// <script>
    class StaticsManager {
        constructor() {
            this.typeMap = {
                audio: ['.mp3', '.ogg', '.wav', '.m4a'],
                video: ['.mp4', '.ogv', '.mpv', '.webm'],
                image: ['.png', '.jpg', '.jpeg', '.gif', '.webp'],
                doc: ['.txt', '.html', '.htm']
            }
            this.filelist = [];
            document.querySelectorAll('.files .file-main .file-link').forEach(element => this.filelist.push(element.href));
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.statics = new StaticsManager());

    class Player {
        // The lyric system made a mess here...
        constructor() {
            this.masterElement = document.getElementById('audioplayer');
            $(this.masterElement).show();
            this.sequence = 'shuffle';
            this.playing = false;   // For tracking whether the song is playing
            this.lyricIndex = 0;    // For tracking which line of lyric is playing
            this.lyricTimeout = 0;  // For tracking when the next line of lyric to show. sometimes needs clearTimeout()
            this.audio = new Audio();
            this.audio.pause();
            this.audio.onended = () => this.play(1);
            this.audio.onerror = () => this.play(1);
            this.songlist = window.statics.filelist.filter(filename => statics.typeMap['audio'].some(format => filename.toLowerCase().endsWith(format)));
            if (this.songlist.length == 0) $(this.masterElement).hide();
            this.nowplaying = 0;    // for tracking current playing song
            this.songlistShuffled = this.songlist.sort((a, b) => 0.5 - Math.random());
            document.getElementById('audioplayer').querySelectorAll('*[data-player], *[data-player-alt]').forEach(element => {
                switch (element.getAttribute('data-player')) {
                    case 'next':
                        element.addEventListener('click', event => {
                            this.play(1);
                        });
                        break;
                    case 'pause':
                        element.addEventListener('click', event => {
                            this.playing ? this.pause() : this.play();
                        });
                        break;
                    case 'status':
                        this.elemStatus = element;
                        break;
                    case 'nowplaying':
                        this.elemNowplaying = element;
                        break;
                }
                switch (element.getAttribute('data-player-alt')) {
                    case 'prev':
                        element.addEventListener('contextmenu', event => {
                            event.preventDefault();
                            this.play(-1);
                        });
                        break;
                    case 'sequence':
                        element.addEventListener('contextmenu', event => {
                            event.preventDefault();
                            if (this.sequence == 'shuffle') {
                                this.sequence = 'sequence';
                            } else {
                                this.sequence = 'shuffle';
                            }
                        });
                        break;
                }
            });
        }
        play(offset = 0) {
            if (offset != 0 || this.audio.src == '') {  // If "play" is just going to continue
                let count = this.nowplaying + offset;
                if (count < 0) count = this.songlist.length + count;
                else if (count >= this.songlist.length) count = count % this.songlist.length;
                this.nowplaying = count;
                this.lyricIndex = 0;
                this.scheduleLyric(-1);
                this.audio.src = this.sequence == 'shuffled' ? this.songlist[count] : this.songlistShuffled[count];
                this.loadLyric(this.audio.src, () => this.audio.play());
            } else {    // If "play" is going to switch song
                if (this.lyricIndex != 0 && this.lyricIndex != -1)  // If this song have lyrics
                    this.audio.currentTime = parseInt(this.lyricKeys[this.lyricIndex]) / 1000;
                this.scheduleLyric(this.lyricIndex + 1);
                this.audio.play();
            }
            this.elemStatus.innerText = '{.!Playing:.}';
            this.elemNowplaying.innerText = helper.getFilename(this.audio.src);
            this.playing = true;
        }
        pause() {
            this.audio.pause();
            this.elemStatus.innerText = '{.!Paused:.}';
            this.playing = false;
            this.scheduleLyric(-1); // clearTimeout() next lyric schedule
        }
        loadLyric(audiofile, callbackfn = () => undefined) {
            // Replace .mp3 etc. with .lrc
            let lyricfile = audiofile.split('.').slice(0, -1).join('.') + '.lrc';
            if (statics.filelist.indexOf(lyricfile) == -1) {
                // No lyric file. at least in filelist
                tooltip_manager.hide();
                this.lyricIndex = -1;
                callbackfn();
                return;
            }
            fetch(lyricfile).then(r => {
                if (!r.ok) {    // If 404
                    tooltip_manager.hide();
                    this.lyricIndex = -1;
                    callbackfn();
                }
                else return r.text();
            }).then(t => {
                if (!t) {
                    callbackfn();
                    return;
                }
                this.lyricIndex = 0;    // init
                let lines = t.split('\n');
                // [ti:title]
                let argRegex = /^\[([a-zA-Z]{2}):(.*)\]$/;
                // [00:00.00]lyric/translation
                let lrcRegex = /^\[(\d+):(\d\d?)(\.\d\d?)\](.*)/;
                this.lyricMap = {
                    0: ''
                }
                for (let i of lines) {
                    if (argRegex.test(i)) {
                        this.lyricMap[0] += i.match(argRegex)[2] + ' - ';
                    } else if (lrcRegex.test(i)) {
                        let matched = i.match(lrcRegex);
                        let time = parseInt(matched[1]) * 60 * 1000 + parseInt(matched[2]) * 1000 + parseFloat(matched[3]) * 1000;
                        this.lyricMap[time] = matched[4].replace('/', '\n');
                    }
                }
                this.lyricKeys = [];
                for (let i in this.lyricMap) this.lyricKeys.push(i);
                this.scheduleLyric(this.lyricIndex);
                callbackfn();
            });
        }
        scheduleLyric(index) {
            // Controls the schedule of lyric strings
            if (this.lyricIndex == -1) return;  // If no lyrics
            if (index == -1) {  // If want clearTimeout()
                clearTimeout(this.lyricTimeout);
                return;
            }
            let lyricMap = this.lyricMap;
            let lyricKeys = this.lyricKeys;
            let delay = lyricKeys[index] - (lyricKeys[index - 1] || 0);
            this.lyricTimeout = setTimeout(() => {
                let lyric = lyricMap[lyricKeys[index]];
                if (lyric === undefined) return;
                tooltip_manager.hide();
                // For a smooth animation
                setTimeout(() => {
                    tooltip_manager.show(lyric);
                    if (lyricKeys[index] != undefined && this.playing) {
                        this.lyricIndex = index;
                        this.scheduleLyric(++index);
                    }
                }, 200);
            }, delay - 201);
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.player = new Player());

    class Previewer {
        // Also file control menu
        constructor() {
            this.selectedFiles = [];
            document.querySelectorAll('.file .file-main .file-link a').forEach(element => {
                let path = helper.getPath(element.href);    // href contains http://.../
                if (path.endsWith('/')) return;
                element.addEventListener('click', event => {
                    event.preventDefault();
                    event.cancelBubble = true;  // prevent selecting item, just preview
                    this.preview(path);
                    this.selectedFiles = [path];
                    this.initMenu('file');
                });
            });
            document.querySelectorAll('.file-main').forEach(element => {
                element.addEventListener('click', event => {
                    element.classList.toggle('selected');
                    let path = helper.getPath(element.querySelector('section.file-link a').href);
                    // if (!path.endsWith('/')) this.preview(path);
                    this.selectedFiles = [... document.querySelectorAll('.file-list section.file-main.selected')].map(x => helper.getPath(x.querySelector('td:nth-child(1) a').href));
                    this.initMenu('selections');
                });
            });
            $('#preview').show();
            document.getElementById('preview').querySelectorAll('*[data-preview]').forEach(element => {
                switch (element.getAttribute('data-preview')) {
                    case 'close':
                        element.addEventListener('click', event => {
                            this.close();
                            this.initMenu();
                        });
                        break;
                    case 'title':
                        this.elemTitle = element;
                        break;
                    case 'menu':
                        this.elemMenu = element;
                        break;
                    case 'content':
                        this.elemContent = element;
                        break;
                }
            });
            this.elemTitle.innerText = helper.getFilename(HFS.folder.slice(0, -1));
            this.initMenu();
        }
        delete(items) {
            dialog.confirm('{.!Delete @items@?.}'.replace('@items@', items.map(x => helper.getFilename(x)).join('; ')), () => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', HFS.folder);
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`action=delete&selection=${items.join('&selection=')}`);
            });
        }
        move(items) {
            dialog.prompt('{.!Move items to:.}', (target) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.move');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`path=${helper.getDirname(items[0])}&from=${items.map(x => helper.getFilename(x)).join(':')}&to=${target}&token=${HFS.sid}`);
            });
        }
        rename(items) {
            if (items.length > 1) {
                dialog.alert('{.!Can only rename 1 file.}');
                return;
            }
            dialog.prompt('{.!Rename item to:.}', (target) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.rename');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`from=${items.join(':')}&to=${target}&token=${HFS.sid}`);
            });
        }
        comment(items) {
            dialog.prompt('{.!Enter comment:.}', (comment) => {
                let xhr = new XMLHttpRequest();
                xhr.open('POST', './?mode=section&id=ajax.comment');
		        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                xhr.onload = () => {
                    dialog.alert('{.!Success.}', () => location.href = (items[0] == HFS.encodedFolder ? '../' : './'));
                }
                xhr.send(`files=${items.join(':')}&text=${comment}&token=${HFS.sid}`);
            });
        }
        archive(items) {
            let form = document.createElement('form');
            form.style.display = 'none';
            form.action = './?mode=archive&recursive';
            form.method = 'POST';
            items.forEach((v, i) => {
                form.append(document.createElement('input'));
                form.children[i].type = 'hidden';
                form.children[i].name = 'selection';
                form.children[i].value = helper.getFilename(v);
            });
            document.body.appendChild(form);
            form.submit();
        }
        initMenu(type = 'folder') {
            function createButton(name, action) {
                let a = document.createElement('a');
                let span = document.createElement('span');
                span.classList.add('menuitem');
                span.innerText = name;
                a.addEventListener('click', action.bind(this));
                a.href = 'javascript:';
                a.style.margin = '0 0.2em';
                a.appendChild(span);
                return a;
            }
            let mark = document.createElement('span');
            mark.style.margin = '0 0.2em';
            let menu = [mark];
            switch (type) {
                case 'folder':
                    mark.innerText = '{.!Folder:.}';
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete([HFS.encodedFolder])));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move([HFS.encodedFolder])));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename([HFS.encodedFolder])));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment([HFS.encodedFolder])));
                        }
                    }
                    break;
                case 'file':
                    mark.innerText = '{.!File:.}';
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment(this.selectedFiles)));
                        }
                    }
                    break;
                case 'selections':
                    mark.innerText = '{.!Selections:.}';
                    menu.push(createButton('{.!Select All.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.add('selected'))));
                    menu.push(createButton('{.!Invert.}', () => document.querySelectorAll('table#files tbody tr').forEach(e => e.classList.toggle('selected'))));
                    if (HFS.can_delete) {
                        menu.push(createButton('{.!Delete.}', () => this.delete(this.selectedFiles)));
                        if (HFS.can_move) {
                            menu.push(createButton('{.!Move.}', () => this.move(this.selectedFiles)));
                        }
                        if (HFS.can_rename) {
                            menu.push(createButton('{.!Rename.}', () => this.rename(this.selectedFiles)));
                        }
                        if (HFS.can_comment) {
                            menu.push(createButton('{.!Comment.}', () => this.comment(this.selectedFiles)));
                        }
                    }
                    menu.push(createButton('{.!Archive.}', () => this.archive(this.selectedFiles)));
                    break;
            }
            this.elemMenu.querySelectorAll('*').forEach(e => e.remove());
            if (menu.length > 1) for (let i of menu) this.elemMenu.appendChild(i);
        }
        close() {
            this.elemContent.querySelectorAll('*').forEach(e => e.remove());
            this.elemTitle.innerText = helper.getFilename(HFS.folder.slice(0, -1));
        }
        preview(url) {
            this.close();
            this.elemTitle.innerText = helper.getFilename(url);
            let type = 'unknown';
            for (let i in statics.typeMap) {
                if (statics.typeMap[i].some(format => url.toLowerCase().endsWith(format))) {
                    type = i;
                    break;
                }
            }
            let wrapperContent = document.createElement('div');
            let wrapperActions = document.createElement('div');
            switch (type) {
                case 'audio':
                    let audio = document.createElement('audio');
                    audio.controls = 'controls';
                    audio.src = url;
                    wrapperContent.appendChild(audio);
                    audio.play();
                    let a0 = document.createElement('a');
                    a0.href = 'javascript:';
                    a0.innerText = '[ {.!Move to mini player.} ]';
                    a0.addEventListener('click', event => {
                        this.close.bind(this)();
                        player.sequence = 'shuffle';
                        player.nowplaying = 0;
                        let number = player.songlistShuffled.map(x => helper.getPath(x)).indexOf(url);
                        player.play(number);
                    });
                    wrapperActions.appendChild(a0);
                    break;
                case 'video':
                    let video = document.createElement('video');
                    video.controls = 'controls';
                    video.src = url;
                    wrapperContent.appendChild(video);
                    video.play();
                    break;
                case 'image':
                    let img = document.createElement('img');
                    img.src = url;
                    wrapperContent.appendChild(img);
                    let a1 = document.createElement('a');
                    a1.href = 'javascript:';
                    a1.innerText = '[ {.!Start Slideshow.} ]';
                    a1.addEventListener('click', event => {
                        this.close.bind(this)();
                        this.slideshow();
                    });
                    wrapperActions.appendChild(a1);
                    break;
                case 'doc':
                    let iframe = document.createElement('iframe');
                    iframe.src = url;
                    wrapperContent.appendChild(iframe);
                    break;
                default:
                    let span = document.createElement('span');
                    span.classList.add('nopreview');
                    span.innerText = '{.!No preview available.}';
                    wrapperContent.appendChild(span);
                    break;
            }
            this.elemContent.appendChild(wrapperContent);
            let download = document.createElement('a');
            let span = document.createElement('span');
            span.innerText = '[ {.!Download.} ]';
            download.appendChild(span);
            download.classList.add('download');
            download.href = url;
            download.download = helper.getFilename(url);
            wrapperActions.appendChild(download);
            this.elemContent.appendChild(wrapperActions);
        }
        slideshow() {
            let pictures = statics.filelist.filter(x => statics.typeMap['image'].some(y => x.endsWith(y)));
            let slideshow = document.querySelector('.slideshow');
            let imgs = slideshow.querySelectorAll('img');
            let n = 0;
            document.body.style.overflow = 'hidden';
            function switchslide() {
                imgs[1].src = pictures[n];
                imgs[1].style.opacity = '1';
                setTimeout(() => {
                    imgs[0].src = pictures[n++];
                    n %= pictures.length;
                    imgs[1].style.opacity = '0';
                }, 1000);
            }
            let interval = setInterval(switchslide, 5000);
            switchslide();
            slideshow.oncontextmenu = event => {
                event.preventDefault();
                $(slideshow).hide();
                document.body.style.overflow = '';
                clearInterval(interval);
            }
            $(slideshow).show();
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.previewer = new Previewer());

    class ThumbsManager {
        constructor() {
            this.buttonShowThumb = document.getElementById('showthumb');
            this.buttonShowThumb.addEventListener('click', this.showThumb.bind(this));
            if (statics.filelist.some(x => statics.typeMap['image'].some(y => x.endsWith(y)))) {
                $(this.buttonShowThumb).show();
            };
            this.shown = false;
        }
        showThumb() {
            if (this.shown) return;
            this.shown = true;
            let items = document.querySelectorAll('table#files tbody tr td:nth-child(1)');
            items.forEach(element => {
                let a = element.querySelector('a');
                if (statics.typeMap['image'].some(x => a.href.endsWith(x))) {
                    let img = document.createElement('img');
                    img.classList.add('thumb');
                    img.loading = 'lazy';
                    img.src = a.href;
                    element.prepend(img);
                }
            });
        }
    }
    window.addEventListener('DOMContentLoaded', () => window.thumbs_manager = new ThumbsManager());
// </script>

[upload]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload.}</title>
    <style>
    .upload-panel{grid-area: part1;margin: 0 auto;}
    .upload-panel .heading{font-size: 24px;}
    .linebottom{grid-area:nav;text-align: center;margin: 0 auto;width: 50%;}
    .linebottom .n-fldr{margin-top: 20px;}
    </style>
|
    <section class="linebottom" style="text-align: left;">
        <div class="n-fldr">
        <a href="./"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M6.535 3H21a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H6.535a1 1 0 0 1-.832-.445l-5.333-8a1 1 0 0 1 0-1.11l5.333-8A1 1 0 0 1 6.535 3zM13 10.586l-2.828-2.829-1.415 1.415L11.586 12l-2.829 2.828 1.415 1.415L13 13.414l2.828 2.829 1.415-1.415L14.414 12l2.829-2.828-1.415-1.415L13 10.586z" fill="rgba(255,255,255,1)"/></svg> {.!Back.}</a>
        {.if|{.can mkdir.}|
            <a id="newfolder" class="invert" style="float: right;" href="javascript:">📁 {.!New Folder.}</a>
        .}
    </section>
    <section class="upload-panel">
        <p class="heading">{.!Upload to:.}%folder%</p>
        <p class="heading">{.!Free space left:.}%diskfree%B</p>
        <form id="uploadform" action="./" target="_parent" method="POST" enctype="multipart/form-data">
            <p data-upload="inputs"><input class="select" type="file" name="0" multiple /><br /></p>
            <a class="invert" href="javascript:" data-upload="add">{.!Add.}</a>
            <input type="submit" value="{.!Upload.}" />
        </form>
    </section>
    <script>
        class Uploader {
            constructor() {
                this.count = 1;
                document.getElementById('newfolder').addEventListener('click', this.createfolder.bind(this));
                document.getElementById('uploadform').querySelectorAll('*[data-upload]').forEach(element => {
                    switch (element.getAttribute('data-upload')) {
                        case 'inputs':
                            this.inputs = element;
                            break;
                        case 'add':
                            element.addEventListener('click', this.add.bind(this));
                            break;
                    }
                });
            }
            add() {
                let input = document.createElement('input');
                input.type = 'file';
                input.multiple = 'multiple';
                input.name = this.count++;
                this.inputs.appendChild(input);
                let br = document.createElement('br');
                this.inputs.appendChild(br);
            }
            createfolder() {
                dialog.prompt('{.!Input folder name.}', i => {
                    let xhr = new XMLHttpRequest();
                    xhr.open('POST', './?mode=section&id=ajax.mkdir');
					xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
                    xhr.onload = () => {
                        let message = xhr.responseText.trim();
                        switch (message) {
                            case 'Bad Token':
                                dialog.alert('{.!Bad session. Please try again..}', () => location.href = '.');
                                break;
                            case 'Forbidden':
                                dialog.alert('{.!Illegal action.}');
                                break;
                            case 'Duplicate':
                                dialog.alert('{.!Folder already exists.}');
                                break;
                            case 'OK':
                                dialog.alert('{.!Done..}', () => location.href = './');
                                break;
                            default:
                                dialog.alert(`{.!Error:.}${message}`);
                                break;
                        }
                    }
                    xhr.send(`name=${i}&token=${HFS.sid}`);
                });
            }
        }
        window.addEventListener('DOMContentLoaded', event => window.uploader = new Uploader());
    </script>
.}

[upload-results]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload Result.}</title>
    <style>
        .success {
            color: #66ff66;
        }
        .failed {
            color: #ff6666;
        }
    </style>
|
    <section class="linebottom">
        <a href="./">⇦ {.!Back.}</a>
    </section>
    <h1>{.!Upload Result.}</h1>
    <p>%uploaded-files%</p>
    <script>
        window.addEventListener('DOMContentLoaded', event => {
            if (document.querySelector('.failed') != null) {
                dialog.alert('{.!There are some files failed to upload..}');
            } else {
                dialog.alert('{.!All files are uploaded successfully.}', () => location.href = './');
            }
        });
    </script>
.}

[upload-success]
<b class="success">{.!Success.}</b>: %item-name% - %item-size%B - %speed% KB/s<br />

[upload-failed]
<b class="failed">{.!FAILED.}</b>: %item-name% - %reason%<br />

{.comment|
    IMPORTANT:
        Through these macros are from original template,
        they are heavily modified, and maybe cannot fit your need.
        Please check how macros exactly work if going to adapt.
.}

[+special:alias]
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result=Bad Session.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|"|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes

[ajax.mkdir|no log|public]
{.check session.}
{.set|x|{.postvar|name.}.}
{.break|if={.pos|\|var=x.}{.pos|/|var=x.}|result=Forbidden.}
{.break|if={.not|{.can mkdir.}.}|result=Forbidden.}
{.set|x|{.force ansi|%folder%{.^x.}.}.}
{.break|if={.exists|{.^x.}.}|result=Duplicate.}
{.break|if={.not|{.length|{.mkdir|{.^x.}.}.}.}|result=Forbidden.}
{.add to log|> .. {.!User.} %user% {.!created folder.} "{.^x.}".}
{.pipe|OK.}

[ajax.rename|no log|public]
{.check session.}
{.break|if={.not|{.can rename.}.}|result=Forbidden.}
{.break|if={.is file protected|{.postvar|from.}.}|result=Forbidden.}
{.break|if={.is file protected|{.postvar|to.}.}|result=Forbidden.}
{.set|x|{.force ansi|{.postvar|from.}.}.}
{.set|y|{.force ansi|%folder%{.postvar|to.}.}.}
{.break|if={.not|{.exists|{.^x.}.}.}|result=Not Found.}
{.break|if={.exists|{.^y.}.}|result=Duplicate.}
{.break|if={.not|{.length|{.rename|{.^x.}|{.^y.}.}.}.}|result=Failed.}
{.add to log|> .. {.!User.} %user% {.!renamed.} "{.^x.}" {.!to.} "{.^y.}".}
{.pipe|OK.}

[ajax.move|no log|public]
{.check session.}
{.set|to|{.force ansi|{.postvar|to.}.}.}
{.break|if={.not|{.and|{.can move.}|{.get|can delete.}|{.get|can upload|path={.^to.}.}/and.}.} |result=Forbidden.}
{.set|log|> .. {.!Moving items to.} {.^to.}.}
{.for each|filename|{.replace|:|{.no pipe||.}|{.force ansi|{.postvar|from.}.}.}|{:
	{.break|if={.is file protected|var=filename.}|result=Forbidden.}
	{.set|x|{.force ansi|{.postvar|path.}.}{.^filename.}.}
	{.set|y|{.force ansi|{.postvar|path.}.}{.^to.}/{.^filename.}.}
	{.if not |{.exists|{.^x.}.}|{:{.^x.}: {.!Not found.}:}|{:
		{.if|{.exists|{.^y.}.}|{:{.^y.}: {.!Duplicate.}:}|{:
			{.set|comment| {.get item|{.^x.}|comment.} .}
			{.set item|{.^x.}|comment=.} {.comment| this must be done before moving, or it will fail.}
			{.if|{.length|{.move|{.^x.}|{.^y.}.}.} |{:
				{.move|{.^x.}.md5|{.^y.}.md5.}
				{.set|log|{.chr|13.}> .. {.^filename.} -> {.^y.}|mode=append.}
				{.set item|{.^y.}|comment={.^comment.}.}
			:} | {:
				{.set|log|{.chr|13.}> !! {.^filename.}: {.!Move failed.}|mode=append.}
				{.maybe utf8|{.^filename.}.}: {.!Not moved.}
			:}/if.}
		:}/if.}
	:}.}
	{.chr|13.}
:}.}
{.add to log|{.^log.}.}

[ajax.comment|no log|public]
{.check session.}
{.break|if={.not|{.can comment.}.} |result=Forbidden.}
{.for each|filename|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
	 {.break|if={.is file protected|var=filename.}|result=Forbidden.}
	 {.set item|{.force ansi|{.^filename.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|OK.}

[ajax.changepwd|public|no log]
{.check session.}
{.break|if={.not|{.can change pwd.}.} |result=Forbidden.}
{.if|{.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}|
	{:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|OK|Failed.}:}|
	{:Unauthorized:}
.}


[login|public]
{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    {.if|%user%|
    <title>{.!Manage Account.}</title>
    |
    <title>{.!Login.}</title>
    .}
|
    {.if|%user%|
    <section class="log-mang">
        <h1>{.!Manage Account.}</h1>
        <noscript>
            <p>{.!Javascript required.}</p>
        </noscript>
        <p class="log-usr">
            <span>%user%</span><br />
            <a id="logout" class="invert" href="javascript:">{.!Logout.}</a>
        </p>
        <form id="changepwd">
            <p>{.!Change password.}</p>
            <input type="password" name="old" placeholder="{.!Old password.}" /><br />
            <input type="password" name="new" placeholder="{.!New password.}" /><br />
            <input type="password" name="verify" placeholder="{.!Enter again.}" /><br />
            <input type="submit" value="{.!OK.}" />
        </form>
        <script src='/~sha256.js'></script>
        <script>
            class AccountManager {
                constructor() {
                    this.formChangepwd = document.getElementById('changepwd');
                    this.passwords = this.formChangepwd.querySelectorAll('input[type="password"]');
                    this.formChangepwd.addEventListener('submit', event => {
                        event.preventDefault();
                        if (this.passwords[1].value != this.passwords[2].value) {
                            dialog.alert('{.!New password not match.}');
                            this.passwords[1].value = '';
                            this.passwords[2].value = '';
                            return
                        }
                        let xhr = new XMLHttpRequest();
                        xhr.open('POST', './?mode=section&id=ajax.changepwd');
		                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.onload = () => {
                            let message = xhr.responseText.trim();
                            switch (message) {
                                case 'OK':
                                    dialog.alert('{.!Success.}', () => location.href = location.hash.slice(1));
                                    if (localStorage.getItem('password') != null) {
                                        localStorage.setItem('password', btoa(this.passwords[1].value));
                                    }
                                    break;
                                case 'Forbidden':
                                case 'Failed':
                                    dialog.alert('{.!Failed.}', () => location.href = location.hash.slice(1));
                                    break;
                                case 'Unauthorized':
                                    dialog.alert('{.!Old password is incorrect.}');
                                    this.passwords[0].value = '';
                                    break;
                            }
                        }
                        xhr.send(`token=${HFS.sid}&old=${SHA256.hash(this.passwords[0].value)}&new=${btoa(unescape(encodeURIComponent(this.passwords[1].value)))}`);
                    });
                    document.getElementById('logout').addEventListener('click', event => {
                        fetch('/?mode=logout').then(r => location.href = location.hash.slice(1));
                    });
                }
            }
            window.addEventListener('DOMContentLoaded', () => window.account_manager = new AccountManager());
        </script>
    </section>
    |
    <section class="log-in">
        <h1>Login</h1>
        <noscript>
            <p>{.!Javascript required.}</p>
        </noscript>
        <form>
            <input type="text" name="username" placeholder="{.!Username.}" /><br />
            <input type="password" name="password" placeholder="{.!Password.}" /><br />
            <label><input type="checkbox" name="remember" /> {.!Remember credentials.}</label>
            <input type="submit" value="{.!Login.}" style="cursor: pointer;" />
        </form>
        <script src='/~sha256.js'></script>
        <script>
            class LoginManager {
                constructor() {
                    this.inputUsername = document.querySelector('input[name="username"]');
                    this.inputPassword = document.querySelector('input[name="password"]');
                    this.inputRemember = document.querySelector('input[name="remember"]');
                    this.form = document.querySelector('form');
                    this.form.addEventListener('submit', event => {
                        event.preventDefault();
                        this.login.bind(this)();
                    });
                    if (localStorage.getItem('username') != null && localStorage.getItem('password') != null) {
                        this.inputRemember.checked = true;
                        this.inputUsername.value = localStorage.getItem('username');
                        this.inputPassword.value = atob(localStorage.getItem('password'));
                    }
                }
                login() {
                    let username = this.inputUsername.value;
                    let password = this.inputPassword.value;
                    let token = HFS.sid;
                    let xhr = new XMLHttpRequest();
                    xhr.open('POST', '/?mode=login');
                    let formdata = new FormData();
                    formdata.append('user', username);
                    if (typeof SHA256 == 'undefined') {
                        formdata.append('password', password);
                    } else {
                        let hashed = SHA256.hash(SHA256.hash(password).toLowerCase() + token).toLowerCase();
                        formdata.append('passwordSHA256', hashed);
                    }
                    xhr.onload = () => {
                        let message = xhr.responseText.trim();
                        switch (message) {
                            case 'ok':
                                if (this.inputRemember.checked) {
                                    localStorage.setItem('username', username);
                                    localStorage.setItem('password', btoa(password));
                                } else {
                                    localStorage.removeItem('username');
                                    localStorage.removeItem('password');
                                }
                                dialog.alert('{.!Success.}', () => location.href = location.hash.slice(1));
                                break;
                            case 'bad password':
                                dialog.alert('{.!Incorrect password.}', () => location.reload());
                                this.inputPassword.value = '';
                                break;
                            case 'username not found':
                                dialog.alert('{.!User not found.}');
                                this.inputUsername.value = '';
                                this.inputPassword.value = '';
                                break;
                            default:
                                dialog(`{.!Error:.}${message}`);
                                break;
                        }
                    }
                    xhr.send(formdata);
                }
            }
            window.addEventListener('DOMContentLoaded', () => window.login_manager = new LoginManager());
        </script>
    </section>
    .}
.}


[error-page]
{.add header|Cache-Control: no-cache, max-age=0.}
%content%

[overload]
{.disconnect.}

[max contemp downloads]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~server-busy-page.html#{.filepath|%url%.}.}

[server-busy-page.html|public]
{.get-common-html|
    <title>{.!Server Busy.}</title>
|
    <section class="linebottom">
        <a href="javascript: location.href = location.hash.slice(1);" class="invert">{.!Retry.}</a>
    </section>
    <h1>{.!Server Busy.}</h1>
    <p>{.!Please try again later..}</p>
.}

[not found]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~404-page.html.}

[404-page.html|public]
{.get-common-html|
    <title>{.!404: Not Found.}</title>
|
    <section class="linebottom">
        {.if|{.=|{.cut|-1||%url%.}|/.}|
            <a href="../">⇦ {.!Back.}</a>
        |
            <a href="./">⇦ {.!Back.}</a>
        .}
    </section>
    <h1>{.!404: Not Found.}</h1>
    <p>{.!You have found a 404 page..}</p>
    <script>
        setTimeout(() => document.querySelector('a').click(), 3000);
    </script>
.}

[unauth]
{.redirect|/~login.}

[deny]
{.disconnect.}

[ban]
{.disconnect.}


[takeback-general.css|public|no log|cache]
/* <style> /**/
html{
    font-family: 'Roboto';
}
body {
    margin: 0;
    background: #1b1b1b;color: #fff;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 60px 60px 1fr;
    grid-template-areas: "nav nav nav" "control control control" "part1 part1 part1" 
    "part1 part1 part1";
    height: 100%;
}
.animator-show { transform: inherit; }
.animator-hide { transform: scaleY(0); }

h1 {
    font-size: 1.8em;
}
section#tooltip {
    position: fixed;
    bottom: 3.6em;
    width: 100%;
    min-height: 2em;
    border-top: 1px solid currentColor;
    border-bottom: 1px solid currentColor;
    background-color: rgba(0, 0, 0, 0.8);
}
a:link, a:visited {
    color:#fff;
}
a:hover {
    color: #1967d2;
}
a:active {
    color: white;
}

a.invert:link, a.invert:visited {
    color: #333333;
}
a {
    color: rgba(255, 255, 255, 0.651);transition: all 0.3s;text-decoration: none;
}

svg {
    opacity: 0.8;
}

a svg {
    opacity: 0.8;
}

svg:hover {
    opacity: 1;
}

a svg:hover {
    opacity:1;}
#dialog {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    transition: opacity 0.6s;
}
.dialog {
    position: fixed;width: 60%;left: 20%;top: 33%;border: 1px solid #19f919;border-radius: 5px;font-weight: bold;color: #19f919;text-align: center;
}
.dialog .prompt-input {
    width: 12em;
    font-size: 1.2em;
    height: 1em;
    border: 1px solid currentColor;
}#dialog .dialog .animation-show p a.ok-btn {color: #55ff49;}
.log-mang{text-align: center;width: 80%;grid-area: part1;}
.log-mang .log-usr span{font-size: 24px;font-family: sans-serif;font-weight: bold;color: #9400ff;}
.log-mang .log-usr  #logout{color: #ff4954;font-family: sans-serif;}
#changepwd p{font-weight: bold;font-size: 24px;color: #55ff46;}
.log-in{grid-area: part1;text-align: center;width: 80%;}
.log-in h1{color: #55ff49;}
.log-in form input{padding: 8px;font-size: 16px;margin: 20px 0;background: #fff;border-radius: 5px;border: 1px solid #fff;}
#changepwd input{padding: 8px;font-size: 16px;margin: 20px 0;background: #fff;border-radius: 5px;border: 1px solid #fff;}

@media (max-width: 950px) {
    section#tooltip {
        bottom: unset;
        top: 1.8em;
    }
}
/* </style> */
// </style>

[takeback-filelist.css|public|no log|cache]
/* <style> /**/
@keyframes blinkgreen {
    0% {
        color: green;
    }
    50% {
        color: #66ee66;
    }
    100% {
        color: green;
    }
}
.part1 {
width: 95%;grid-area: part1;margin: 0 auto;
}
.part1 #files-list {
    display: flex;flex-direction: column;
}
.part1 #files-grid{
display: grid;
grid-gap: 5px;
grid-template-columns: repeat(auto-fit, minmax(250px, 250px));
}
.files-list{}
#file-main.selected{border: 2px solid #ff5549;}
#files-list .file-main{display: flex;justify-content: space-around;}
#files-list .file-main .file-link{width: 75%;display: flex;}
#files-list .file-main .file-link a{display: flex;}
#files-list .file-main .file-link a svg{position: relative;top: 13px;margin-right: 2px;}
#files-list .file-main .file-date{width: 15%;display: flex;justify-content: center;}
#files-list .file-main .file-type{width: 15%;display: flex;justify-content: center;}
/*
.part1 table#files td:nth-child(1) {
    width: 75%;
    text-align: left;
}
.part1 table#files td:nth-child(1) img.thumb {
    height: 8em;
    vertical-align: middle;
}
.part1 table#files td:nth-child(2) {
    width: 15%;
    text-align: center;
}
.part1 table#files td:nth-child(3)  {
    width: 10%;
    text-align: right;
}
.part1 table#files thead td:nth-child(3) {
    text-align: center;
}
.part1 table#files thead td {
    background-color: white;
    color: #333333;
    font-weight: bold;
}
.part1 table#files thead td a:hover {
    color: #333333;
}
.part1 table#files tbody tr {
    border-bottom: 1px solid #dadce0;
    transition: all 0.3s;
}
.part1 table#files tbody tr p {
    margin: 0;
    margin-left: 1em;
    border-left: 1px solid white;
    padding-left: 1em;
}
.part1 table#files tbody tr:hover {
background-color: #b9b9b938;
}
.part1 table#files tbody tr.selected {
    outline: 1px solid yellow;
}
.part1 table#files .folder td:nth-child(3),
.part1 table#files .link td:nth-child(3), td:nth-child(2) {
    color: #fff;opacity: 0.8;
    font-style: italic;
    text-align: center;
}
.part1 table#files tr td {
	height: 32px;
}*/
.part2 .blank {
    height: 20em;
}
.part3 .left, .part3 .right {
    position: fixed;
    bottom: 0em;
    display: inline-block;
}
.part3 .left #audioplayer, .part3 .right #preview {
    background-color: rgba(0, 0, 0, 0.8);
}
.part3 .left {
    left: 0;
    text-align: left;
}
.part3 .right {
    right: 0;
    min-width: 24em;
}
.part3 .right #preview .close {
    float: right;
}
.part3 .right #preview .close span {
    color: #ff6666;
}
.part3 .right #preview .title {
    text-align: left;
}
.part3 .right #preview video, .part3 .right #preview img {
    max-height: 16em;
}
.part3 .right #preview iframe {
    width: 24em;
    height: 16em;
    border: none;
    background-color: white;
}
.part3 .right #preview .nopreview {
    color: yellow;
}
.part3 .right #preview a span.menuitem {
    color: rgb(255, 160, 96);
    text-decoration: underline;
    font-size: 0.9em;
}
.part3 .right #preview a.download span {
    color: cyan;
}
.slideshow {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    text-align: center;
    background-color: black;
}
.slideshow img {
    height: 100%;
    display: block;
    transition: all 1s;
    position: absolute;
}
@keyframes swing {
    0% {
        left: -0.5em;
    }
    50% {
        left: 0em;
    }
    100% {
        left: -0.5em;
    }
}
.arrow {
    position: relative;
    animation: swing 1s ease-in-out 0s infinite;
}
.arrow::after {
    content: '>>';
    font-style: italic;
}

@media (max-width: 950px) {
    .part3 .left {
        bottom: 3.6em;
        overflow-x: visible;
        white-space: nowrap;
    }
    .part3 .right {
        min-width: unset;
        width: 100%;
    }
}
/*
/* Folder */
.file-link a[href$="/"]::before {
	content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
	position: relative;
	width: 1.75em;
	top: 10px;
}

/* Unknown File */
/*td a::before {
	content: "\1f4c4";
	color: #BCC;
	display: inline-block;
	position: relative;
	width: 1.75em;
	text-align: center;
}*/

/* Other */
/*td a[href$=";"]::before,    /* javascript: ...; */
/*td a[href$=":"]::before,    /* javascript: */
/*td a[href*="?"]::before {
	content: none;
}*/

/* Picture */
/*a[href$=".jpg"]::before,
a[href$=".JPG"]::before,
a[href$=".webp"]::before,
a[href$=".png"]::before,
a[href$=".PNG"]::before,
a[href$=".gif"]::before,
a[href$=".GIF"]::before {
	content: "\ee44";color: #fff;
}*/

/* Working Picture (Photoshop & GIMP) */
/*a[href$=".psd"]::before,
a[href$=".xcf"]::before {
	content: "📸";
	color: #5AE
}*/

/* Audio/Music */
/*a[href$=".mp3"]::before,
a[href$=".MP3"]::before,
a[href$=".aac"]::before,
a[href$=".m4a"]::before,
a[href$=".wav"]::before,
a[href$=".ogg"]::before {
	content: "\1f50a\FE0E";
	color: green
}*/

/* Video */
/*a[href$=".mp4"]::before,
a[href$=".MP4"]::before,
a[href$=".avi"]::before,
a[href$=".AVI"]::before,
a[href$=".webm"]::before,
a[href$=".ogv"]::before,
a[href$=".flv"]::before,
a[href$=".mkv"]::before {
	content: "\1f4fa";
	color: teal
}
*/
/* Compressed/Storage Pack */
/*a[href$=".tar"]::before,
a[href$=".gz"]::before,
a[href$=".xz"]::before,
a[href$=".rar"]::before,
a[href$=".7z"]::before,
a[href$=".zip"]::before {
	content: "\1f381";
	color: brown
}*/

/* Installation Pack */
/*a[href$=".msi"]::before,
a[href$=".tar.gz"]::before,
a[href$=".deb"]::before,
a[href$=".rpm"]::before {
	content: "📦";
	color: brown
}*/

/* Executable/Script */
/*a[href$=".exe"]::before,
a[href$=".EXE"]::before,
a[href$=".vbs"]::before,
a[href$=".bat"]::before,
a[href$=".sh"]::before,
a[href$=".ps1"]::before,
a[href$=".pyc"]::before,
a[href$=".apk"]::before {
	content: "\1f537";
	color: #5AE
}*/

/* Code */
a[href$=".c"]::before,
a[href$=".cpp"]::before,
a[href$=".h"]::before,
a[href$=".cxx"]::before,
a[href$=".gcc"]::before,
a[href$=".py"]::before,
a[href$=".js"]::before {
	content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 5v2h2V7h-2zm0 4v6h2v-6h-2z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
	
}

/* Working Document */
/*a[href$=".rtf"]::before,
a[href$=".RTF"]::before,
a[href$=".doc"]::before,
a[href$=".DOC"]::before,
a[href$=".docx"]::before,
a[href$=".odt"]::before,
a[href$=".xls"]::before,
a[href$=".xlsx"]::before,
a[href$=".ods"]::before,
a[href$=".ppt"]::before,
a[href$=".pptx"]::before,
a[href$=".odp"]::before {
	content: "📝";
	color: gray;
}*/

/* E-Books */
/*a[href$=".epub"]::before,
a[href$=".PDF"]::before,
a[href$=".pdf"]::before {
	content: "📕";
	color: red;
}*/

/* Other Text */
/*a[href$=".txt"]::before,
a[href$=".TXT"]::before,
a[href$=".ini"]::before,
a[href$=".htm"]::before,
a[href$=".HTM"]::before,
a[href$=".html"]::before,
a[href$=".cfg"]::before,
a[href$=".json"]::before,
a[href$=".lrc"]::before {
	content: "📑";
	color: thistle;
}*/

/* Flash */
/*a[href$=".swf"]::before {
	content: "⚡";
	color: gold;
}*/

/* Icon */
/*a[href$=".ICO"]::before,
a[href$=".ico"]::before {
	content: "🥚";
	color: wheat;
}*/

/* (Data) Image */
/*a[href$=".iso"]::before,
a[href$=".img"]::before,    /* '.img' is a floppy💾 image💿 */
/*a[href$=".dda"]::before {
	content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M13.95 2H20a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-8.05c.329.033.663.05 1 .05 5.523 0 10-4.477 10-10 0-.337-.017-.671-.05-1zM15 16v2h2v-2h-2zM11.938 2A8 8 0 0 1 3 10.938V3a1 1 0 0 1 1-1h7.938z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
}

/* Link */
.file-link a[href^="ftp://"]::before,
.file-link a[href^="file://"]::before,
.file-link a[href^="tcp://"]::before,
.file-link a[href^="udp://"]::before,
.file-link a[href^="rtmp://"]::before,
.file-link a[href^="rtsp://"]::before,
.file-link a[href^="http://"]::before,
.file-link a[href^="https://"]::before {
	content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 13v2h2v-2h-2zm2-1.645A3.502 3.502 0 0 0 12 6.5a3.501 3.501 0 0 0-3.433 2.813l1.962.393A1.5 1.5 0 1 1 12 11.5a1 1 0 0 0-1 1V14h2v-.645z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
}

@media (min-width:950px) {
    ::-webkit-scrollbar {
        width: 10px;
        height: 10px;
        background-color: transparent;
    }
    ::-webkit-scrollbar-button {
        width: 0;
        height: 0;
    }
    ::-webkit-scrollbar-button:end:increment,::-webkit-scrollbar-button:start:decrement {
        display: block;
    }
    ::-webkit-scrollbar-button:vertical:end:decrement,::-webkit-scrollbar-button:vertical:start:increment {
        display: none;
    }
    ::-webkit-scrollbar-thumb:horizontal,::-webkit-scrollbar-thumb:vertical,::-webkit-scrollbar-track:horizontal,::-webkit-scrollbar-track:vertical {
        border-color: transparent;
        border-style: solid;
    }
    ::-webkit-scrollbar-track:vertical::-webkit-scrollbar-track:horizontal {
        /* background-color: rgba(255,255,255,.2); */
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
    }
    ::-webkit-scrollbar-thumb {
        min-height: 28px;
        padding-top: 100;
        background-color: rgba(255,255,255,.2);
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
        border-radius: 5px;
    }
    ::-webkit-scrollbar-thumb:hover {
        background-color: rgba(255,255,255,.24);
        box-shadow: inset 1px 1px 1px rgba(0,0,0,.25);
    }
    ::-webkit-scrollbar-thumb:active {
        background-color: rgba(255,255,255,.12);
        box-shadow: inset 1px 1px 3px rgba(0,0,0,.35);
    }
    ::-webkit-scrollbar-thumb:horizontal,::-webkit-scrollbar-thumb:vertical,
    ::-webkit-scrollbar-track:horizontal,::-webkit-scrollbar-track:vertical {
        border-width: 0;
    }
    ::-webkit-scrollbar-track:hover {
        background-color: rgba(0,0,0,.05);
        box-shadow: inset 1px 0 0 rgba(0,0,0,.1);
    }
    ::-webkit-scrollbar-track:active {
        background-color: rgba(0,0,0,.05);
        box-shadow: inset 1px 0 0 rgba(0,0,0,.14), inset -1px -1px 0 rgba(0,0,0,.07);
    }
    .scrollbar-hover::-webkit-scrollbar,.scrollbar-hover::-webkit-scrollbar-button,
    .scrollbar-hover::-webkit-scrollbar-thumb,.scrollbar-hover::-webkit-scrollbar-track {
        visibility: hidden;
    }
    .scrollbar-hover:hover::-webkit-scrollbar,.scrollbar-hover:hover::-webkit-scrollbar-button,.scrollbar-hover:hover::-webkit-scrollbar-thumb,.scrollbar-hover:hover::-webkit-scrollbar-track {
        visibility: visible;
    }
}
nav {
    display: flex;grid-area: nav;height: 60px;width: 100%;background: #1b1b1b;align-items: center;justify-content: space-between;flex-wrap: wrap;position: fixed;z-index: 1;
}

nav .logo {
    color: #fff;
    font-size: 35px;
    font-weight: bold;margin: 0 0 0 20px;
}

nav .search-control {
    border: none;
    border-radius: 5px;
    padding: 8px;
    width: 380px;
    font-size: 16px;
}

nav .login-con {
    display: flex;
    flex-wrap: wrap;
    margin-right: 12px;
}
nav .login-con span{display: flex;}
nav .login-con span svg {
    width: 32px;
    height: 32px;
    margin: auto 0;
}
span.login-con > a{margin: auto 0;margin-left: 10px;}
span.login-con  span p{
    margin-left: 10px;
}.login-l > svg{
    margin-left: 10px;
}
nav .menu-btn i {
    color: #fff;
    font-size: 22px;
    cursor: pointer;
    display: none;
}

input[type="checkbox"] {
    display: none;
}

nav .s-div {
    display: flex;
}

nav .s-div input {
    border-top-right-radius: 0px;
    border-bottom-right-radius: 0px;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
}

nav .s-div button {
    background-color: #fff;
    border: none;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    border-top-left-radius: 0px;
    border-bottom-left-radius: 0px;
}
.sidebar {
    grid-area: sidebar;
    background-color: #c7000b;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    -ms-flex-direction: column;
    -webkit-flex-direction: column;
    flex-direction: column;
    -ms-flex-align: center;
    -webkit-align-items: center;
    position: fixed;
    left: 0;
    bottom: 0;
    top: 60px;
    width: 220px;
}
.sidebar .file-t{width: 90%;word-break: break-word;}
.sidebar .file-t svg {
    width: 24px;
    height: 24px;
    margin: auto 0;position: relative;top: 5px;
}

.sidebar .file-t p {
    font-size: 22px;
    margin: auto 0;
    margin-left: 10px;
}
.additional-panel {
height: 30px;grid-area: control;display: flex;position: sticky;width: 100%;top: 60px;z-index: 1;background: #1b1b1b;
}

.additional-panel .file-t {
    display: flex;
    width: 70%;
}
.additional-panel .file-t span a svg{position: relative;top: 4px}
.additional-panel .file-o {
display: flex;
width: 100%;
justify-content: space-around;
}
.additional-panel .file-o .file-p-c {
    margin: 0 5px;display: flex;
}

.additional-panel .file-o .file-p-c svg {
    width: 24px;
    height: 24px;
    margin: auto 5px;
}

.additional-panel .file-o a {
    margin: auto 5px;
}

.additional-panel .file-o .file-v-l {
    display: block;
    cursor: pointer;
}

.additional-panel .file-o .file-v-g {
    display: none;
    cursor: pointer;
}
.assigner {
width: 95%;display: flex;justify-content: space-around;height: 30px;background: #fff;border-radius: 5px;margin:0 auto;color: #000;grid-area: control;position: sticky;top: 90px;z-index: 1;
}
.assigner p{
    position: relative;top: -12px;
}
.assigner .file-n {
    font-size: 16px; display: flex;width: 70%;
}
.assigner .file-n a svg{position: relative;top: 3px;left: 3px;}.assigner .file-m a svg{position: relative;top: 3px;}.assigner .file-s a svg{position: relative;top: 3px;}
.assigner .file-m{
    width: 15%;display: flex;justify-content: center;
}
.assigner .file-s{
    width: 15%;display: flex;justify-content: center;
}
.assigner .file-n a{margin-right: 10px;}.assigner .file-s a{margin-left: 10px;}
.assigner .file-s p{margin-left: 10px;}.assigner .file-m a{margin-left: 10px;}
.dropbtn {
  cursor: pointer;position: relative;top: 3px;
}

.dropdown {
  position: relative;display: block;
  
}

.dropdown-content {
  display: none;
  position: absolute;
  min-width: 180px;
  overflow: auto;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: #fff;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown a:hover {background-color: #ddd;}

.show {display: block;background: #6c6c6c;}

/* </style> */
// </style>

[Roboto-font.css|public|no log|cache]
{.add header|Cache-Control: public, max-age=31536000.}
/* <style> /* */
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
    src:url(data:application/font-woff2;base64,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) format('woff2');
}

/* </style> */
// </style>
