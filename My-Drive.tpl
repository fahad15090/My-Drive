
[+special:alias|cache]
fallback={.if|$1|$1|$2.}
get-common-html=replace|@head@|$1|@body@|$2|{.$common-html.}
mm-dd-yyyy=time|format={.fallback|{.!_time_format.}|mm/dd/yyyy.}|when={.if|{.!_use_item_added.}|%item-added-dt%|%item-modified-dt%.}
check session=if|{.{.cookie|HFS_SID_.} != {.postvar|token.}.}|{:{.cookie|HFS_SID_|value=|expires=-1.} {.break|result={.!Bad session.}.}:}
can mkdir=and|{.get|can upload.}|{.!option.newfolder.}
can comment=and|{.get|can upload.}|{.!option.comment.}
can rename=and|{.get|can delete.}|{.!option.rename.}
can change pwd=member of|can change password
can move=or|1|1
escape attr=replace|"|"|$1
commentNL=if|{.pos|<br|$1.}|$1|{.replace|{.chr|10.}|<br />|$1.}
add bytes=switch|{.cut|-1||$1.}|,|0,1,2,3,4,5,6,7,8,9|$1 Bytes|K,M,G,T|$1Bytes


[+special:import]
{.if|{.!_optimize_performance.}|{:
    {.set item|/|not as download=*.htm;*.html;*.css;*.mp3;*.png;*.jpg;*.jpeg;*.gif.;*.js.}
    {.set ini|use-system-icons=no.}
    {.set ini|tray-icon-for-each-download=no.}
    {.set ini|enable-fingerprints=no.}
    {.set ini|flash-on= .}
    {.comment|
        New version needs comment feature
        {.set ini|support-descript.ion=no.}
        {.set ini|load-single-comment-files=no.}
    .}
    {.set ini|send-hfs-identifier=no.}
    {.set ini|max-connections=-1.}
    {.set ini|use-iso-date-format=yes.}
:}.}


[+special:strings]
_use_font=1
_background_image=0
_title=0
_player=0
_time_format=0
_header=0
_use_item_added=0
_optimize_performance=1
_use_index=0
_index_data=


[]

{.if|{.and|{.=|%folder%|/.}|{.!_use_index.}.}|{:{.$takeback.index.}:}|{:
    {.get-common-html|
        <title>{.fallback|{.!_title.}|{.!My Drive.}.}%folder%</title>
        <link rel="stylesheet" href="/~takeback-filelist.css" defer />
    |
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
        <!-- Header, Nav, Notice -->
        <section class="part0">
    <nav class="nav">
        <div class="logo">My Drive</div>
        <input type="checkbox" id="click">
        <label for="click" class="menu-btn">
          <i class="fas fa-bars"></i>
        </label>
        <form class="s-div" action="./">
            <input type="search" name="search" class="search-control" placeholder="{.!Search.}" />
            <button type="submit"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28"><path fill="none" d="M0 0h24v24H0z"/><path d="M18.031 16.617l4.283 4.282-1.415 1.415-4.282-4.283A8.96 8.96 0 0 1 11 20c-4.968 0-9-4.032-9-9s4.032-9 9-9 9 4.032 9 9a8.96 8.96 0 0 1-1.969 5.617zm-2.006-.742A6.977 6.977 0 0 0 18 11c0-3.868-3.133-7-7-7-3.868 0-7 3.132-7 7 0 3.867 3.132 7 7 7a6.977 6.977 0 0 0 4.875-1.975l.15-.15z"/></svg></button>
        </form>
    <div class="login-con">
            <span class="login-con">
                <span><p class="usr" >%user%</p></span>
                {.if|%user%|
                    <a class="login-l" href="/~signin#%encoded-folder%"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 14v8H4a8 8 0 0 1 8-8zm0-1c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6zm2.595 5.812a3.51 3.51 0 0 1 0-1.623l-.992-.573 1-1.732.992.573A3.496 3.496 0 0 1 17 14.645V13.5h2v1.145c.532.158 1.012.44 1.405.812l.992-.573 1 1.732-.992.573a3.51 3.51 0 0 1 0 1.622l.992.573-1 1.732-.992-.573a3.496 3.496 0 0 1-1.405.812V22.5h-2v-1.145a3.496 3.496 0 0 1-1.405-.812l-.992.573-1-1.732.992-.572zM18 17a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" fill="#fff"/></svg></a>|
                    <a href="/~signin#%encoded-folder%">{.!Login.}</a>
                .}
            </span>
    </div>
    </nav>
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
        </section>
        %files%
    .}
:}.}


[404-page.html|public]

{.get-common-html|
    {.if|{.=|{.cut|-1||%url%.}|/.}|
        <meta http-equiv="refresh" content="5;url=../" />
    |
        <meta http-equiv="refresh" content="5;url=./" />
    .}
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
.}


[ajax.changepwd|public|no log]

{.check session.}
{.break|if={.not|{.can change pwd.}.} |result=Forbidden.}
{.if|{.=|{.cut|0|4|%version%.}|2.3.}|{:
    {.if|{.=|{.get account||password.}|{.force ansi|{.postvar|old.}.}.}|
        {:{.if|{.length|{.set account||password={.force ansi|{.postvar|new.}.}.}/length.}|OK|Failed.}:}|
        {:Unauthorized:}
    .}
:}.}
{.if|{.=|{.cut|0|4|%version%.}|2.4.}|{:
    {.if|{.=|{.sha256|{.get account||password.}.}|{.force ansi|{.postvar|old.}.}.}|
        {:{.if|{.length|{.set account||password={.force ansi|{.base64decode|{.postvar|new.}.}.}.}/length.}|OK|Failed.}:}|
        {:Unauthorized:}
    .}
:}.}


[ajax.comment|no log|public]

{.check session.}
{.break|if={.not|{.can comment.}.} |result=Forbidden.}
{.for each|filename|{.replace|:|{.no pipe||.}|{.postvar|files.}.}|{:
    {.break|if={.is file protected|var=filename.}|result=Forbidden.}
    {.set item|{.force ansi|{.^filename.}.}|comment={.encode html|{.force ansi|{.postvar|text.}.}.}.}
:}.}
{.pipe|OK.}


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


[api level]
2


[ban]

{.disconnect.}


[common-html]
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#000000"/>
    <meta name="description" content="{.!This is a file sharing site..}" />
    <link rel="stylesheet" href="/~takeback-general.css" defer />
    {.if|{.!_use_font.}|<link rel="stylesheet" href="/~font.css" defer />.}
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
            can_move: '{.can move.}',
            version: '%version%'
        }
    </script>
</head>
<body>
    {.if|{.!_background_image.}|
        <section class="background-image"></section>
    |
        <section class="background"></section>
    .}
    <section class="background-mask"></section>
    <section id="dialog" style="opacity: 0; top: 200%;"></section>
    <section id="tooltip" style="display: none;"></section>
    <script src="/~takeback-general.js"></script>
    @body@
</body>
</html>



[deny]

{.disconnect.}


[error-page]

{.add header|Cache-Control: no-cache, max-age=0.}
%content%


[file]

{.if|{.=|{.cookie|view.}|grid.}|{:
    <div class="file">
        <a href="%item-url%">%item-name%</a><p>%item-comment%</p>
    </div>
:}|{:
    <tr class="file">
        <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
        <td>{.mm-dd-yyyy.}</td>
        <td>%item-size%B</td>
    </tr>
:}.}


[files]
<!-- {.cookie|view.} -->
{.if|{.and|{.!=|{.cookie|view.}|list.}|{.!=|{.cookie|view.}|grid.}.}|{:
    {.cookie|view|value=list.}
:}.}
{.if|{.=|{.postvar|view.}|grid.}|{:
    {.add to log|> .. Change view of %ip% to grid.}
    {.cookie|view|value=grid.}
    {.redirect|..}
:}.}
{.if|{.=|{.postvar|view.}|list.}|{:
    {.add to log|> .. Change view of %ip% to list.}
    {.cookie|view|value=list.}
    {.redirect|..}
:}.}
<!-- Filelist -->
<section class="part1">
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
    <a href="./~folder.tar" data-tooltip="{.!Save files in this folder to an archive.}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" ><path fill="none" d="M0 0h24v24H0z"/><path d="M21 5a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2H16v2h2V5h3zm-3 8h-2v2h-2v3h4v-5zm-2-2h-2v2h2v-2zm2-2h-2v2h2V9zm-2-2h-2v2h2V7z" fill="rgba(255,255,255,1)"/></svg></a>
    
    {.if|{.can mkdir.}|
    <svg title="{.!New folder.}" id='newfolderBtn' onclick='ask(this.innerHTML, "text", name=> ajax("mkdir", { name:name }))' xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2zM11 12H8v2h3v3h2v-3h3v-2h-3V9h-2v3z" fill="#fff"/></svg>
    .}
    {.if|{.=|{.cookie|view.}|list.}|{:
        <script>
            function gridView() {
                let form = document.createElement('form');
                let input = document.createElement('input');
                form.style.display = 'none';
                form.method = 'post';
                input.type = 'hidden';
                input.name = 'view';
                input.value = 'grid';
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        </script>
        <svg id="file-v-g" class="file-v-g" onclick="gridView()" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M14 10v4h-4v-4h4zm2 0h5v4h-5v-4zm-2 11h-4v-5h4v5zm2 0v-5h5v4a1 1 0 0 1-1 1h-4zM14 3v5h-4V3h4zm2 0h4a1 1 0 0 1 1 1v4h-5V3zm-8 7v4H3v-4h5zm0 11H4a1 1 0 0 1-1-1v-4h5v5zM8 3v5H3V4a1 1 0 0 1 1-1h4z" fill="#fff"/></svg>
    :}.}
    {.if|{.=|{.cookie|view.}|grid.}|{:
        <script>
            function gridView() {
                let form = document.createElement('form');
                let input = document.createElement('input');
                form.style.display = 'none';
                form.method = 'post';
                input.type = 'hidden';
                input.name = 'view';
                input.value = 'list';
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        </script>
        <svg id="file-v-l" class="file-v-l" onclick="gridView()" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="240" height="240"><path fill="none" d="M0 0h24v24H0z"/><path d="M11 4h10v2H11V4zm0 4h6v2h-6V8zm0 6h10v2H11v-2zm0 4h6v2h-6v-2zM3 4h6v6H3V4zm2 2v2h2V6H5zm-2 8h6v6H3v-6zm2 2v2h2v-2H5z" fill="#fff"/></svg>
    :}.}
 {.if|{.get|can upload.}|
        <a class="invert" href="./~upload" data-tooltip="{.!Upload some files to this folder.}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M3 19h18v2H3v-2zM13 5.828V17h-2V5.828L4.929 11.9l-1.414-1.414L12 2l8.485 8.485-1.414 1.414L13 5.83z" fill="rgba(255,255,255,1)"/></svg></a>
.}    
    </div>

</div>
</section>
<section class="assigner" id="assigner">
<div class="file-n">
<span><a href="../" ><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path fill="none" d="M0 0h24v24H0z"/><path d="M10.828 12l4.95 4.95-1.414 1.414L8 12l6.364-6.364 1.414 1.414z" fill="rgba(0,0,0,1)"/></svg></a></span>
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
    <main>
        {.if|{.=|{.cookie|view.}|grid.}|{:
            <div id="files">
                %list%
            </div>
        :}|{:
            <table id="files">    
                <tbody>
                    %list%
                </tbody>
            </table>
        :}.}
    </main>
</section>
<!-- Footer -->
<section class="part2">
    <p>
        <a href="./~folder.tar" data-tooltip="{.!Save files in this folder to an archive.}">[ {.!Archive.} ]</a>
    </p>
    <div class="blank"></div>
</section>
<!-- Dashboard -->
<section class="part3">
    <span class="left">
        <span id="audioplayer" style="display: none;">
            <a href="javascript:" data-player="next" data-player-alt="prev">&nbsp;{.fallback|{.!_player.}|\( •̀ ω •́ )✧ ♫.}&nbsp;</a>
            <a href="javascript:" data-player="pause" data-player-alt="sequence">
                <span>&nbsp;►❙&nbsp;</span>
                <span data-player="status"></span>
            </a>
            <span data-player="nowplaying"></span>
        </span>
    </span>
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
<section class="lyrics" style="display: none;">
</section>
{.if|{.=|{.cookie|view.}|list.}|{:
    <script src="/~takeback-filelist.js" defer></script>
:}.}


[folder]
{.if|{.=|{.cookie|view.}|grid.}|{:
    <div class="folder">
        <a href="%item-url%">%item-name%</a><p>%item-comment%</p>
    </div>
:}|{:
    <tr class="folder">
        <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
        <td>{.mm-dd-yyyy.}</td>
        <td>{.!folder.}</td>
    </tr>
:}.}


[font.css|public|no log|cache]

{.add header|Cache-Control: public, max-age=86400.}
/* <style> /* */
@font-face { font-family: 'Monda';
    src: url('data:application/x-font-ttf;base64,AAEAAAASAQAABAAgRkZUTWXx2TAAAKE8AAAAHEdERUYDnAVLAAChWAAAADRHUE9TRrZNAwAAoYwAAAhkR1NVQoUFkl0AAKnwAAAAZE9TLzK8NmN8AAABqAAAAFZjbWFwf0tdrAAACNQAAAO2Y3Z0ICj/AGAAABasAAAAOGZwZ20x/KCVAAAMjAAACZZnYXNwAAAAEAAAoTQAAAAIZ2x5ZsqTYEcAABpQAAB/5GhlYWQCjGS+AAABLAAAADZoaGVhE/sJFAAAAWQAAAAkaG10eB3Q/fkAAAIAAAAG1GxvY2HUZ/WcAAAW5AAAA2xtYXhwAugKZwAAAYgAAAAgbmFtZc8OhBwAAJo0AAAG3nBvc3QAAwAAAAChFAAAACBwcmVwFQScMAAAFiQAAACFAAEAAAABAADbbxJ5Xw889QAJCAAAAAAAzNqNfQAAAADM3oz+/zL9DAqECDoAAAAIAAIAAAAAAAAAAQAACZ38lQAAC0b/1/+DCoQAAQAAAAAAAAAAAAAAAAAAAbUAAQAAAbUAWQAHAEAABAACACYANABsAAAAkgmWAAMAAgABA80BkAAFAAAFMwWZAAABHgUzBZkAAAPXAGYCEgAAAgAFAwAAAAAAAKAAAO9AACBLAAAAAAAAAABuZXd0AEAAIPsECZ38lQAACZ0DawAAAJMAAAAAAAAC7ABEAAAAAAKqAAACAAAAAwABGAN6ALAFBABWBRcAkAgAAKwF3ACwA4AAswMAAKwDAAB8BAAAYwQAAKICgQDABAAAogJ0ALoDAABABOIAhATiAM4E4gCkBOIA0ATiAI8E4gCtBOIAsgTiAL0E4gCEBOIAlwMAAQADAAD4BOIAnATiAOAE4gDQBNgAswgAAWoFlABWBYwA2gWwALYF8gDaBOcA2gSHANoGFAC6BfgA1ARsAL4EtgBmBYoA2gR5ANoG8gDaBjoA2gYKALoFLgDaBgYAugW4ANoFGACQBLQAVAYCAMgFagBWCAAAcAU4AF4FJgAwBNoAtAMAAQADAABAAwAAwwTpAJoDoQAOAmgAcwSUAIQEtAC6BFYAlASwAJQEhgCUAxYAbgSiAJQEygC6AlQAzgJaAA0EgAC6ArgAvgdEALoEygC6BJYAlASuALoEsACUAxoAugPgAI4DSABQBMgAsARQAEAGTgA0BCAAQAReAEwDxACMA7gAngKyAQADuACAA3EAQAIAAAADAAEYBFYAlAT5AKYEfQB0BSYAMAKiAP4D6gCQBAEAngb4AJwEFQC6BB4AYANgAGIEAACiBvgAnAIBACAEDADCBBEAzwQcAL4ElQDIAmgAhQEzAAAE4gCoAZwAbAIAAHgEGgDPA/8AmwQeAH4H/wCkB/8ApAf/AMcE2ACTBZQAVgWUAFYFlABWBZQAVgWUAFYFlABWBpYAYgWwALYE5wDaBOcA2gTnANoE5wDaBGwAvgRsAL4EbAC+BGwAvgS/AEwGOgDaBgoAugYKALoGCgC6BgoAugYKALoDzQCBBgoAugYCAMgGAgDIBgIAyAYCAMgFJgAwBSgA1AUBAL4ElACEBJQAhASUAIQElACEBJQAhASUAIQGzQCDBFYAlASGAJQEhgCUBIYAlASGAJQCVP/2AlQAzgJUAA4CVP/KBIYAlgTKALoElgCUBJYAlASWAJQElgCUBJYAlAQBAGQElgCUBMgAsATIALAEyACwBMgAsAReAEwEqgCxBF4ATAWUAFYElACEBZQAVgSUAIQFlABWBJQAhAWwALYEVgCUBbAAtgRWAJQFsAC2BFYAlAWwALYEVgCUBfIA2gSwAJQEvwBMBLAAlATnANoEhgCUBOcA2gSGAJQE5wDaBIYAlATnANoEhgCUBOcA2gSGAJQGFAC6BKIAlAYUALoEogCUBhQAugSiAJQGFAC6BKIAlAX4ANQEygC6BgAAkATIAB0EbAC+AlQAAwRsAL4CVABkBGwAvgJUAEoEbAC+AlQAewRsAL4CVADOCSIAvgSuAM4EtgBmAloACgWKANoEgAC6BHwAugR5ANoCuAC+BHkA2gK4AL4EeQDaArgAvgR5ANoEVAC+BHkANALEADQGOgDaBMoAugY6ANoEygC6BjoA2gTKALoEygC6Bi4A1ATKALoGCgC6BJYAlAYKALoElgCUBgoAugSWAJQGFQC3BsYAlgW4ANoDGgC6BbgA2gMaALoFuADaAxoAsgUYAJAD4ACOBRgAkAPgAI4FGACQA+AAjgUYAJAD4ACOBLQAVANIAFAEtABUA0gAUAS0AFQDSAA6BgIAyATIALAGAgDIBMgAsAYCAMgEyACwBgIAyATIALAGAgDIBMgAsAYCAMgEyACwCAAAcAZOADQFJgAwBF4ATAUmADAE2gC0A8QAjATaALQDxACMBNoAtAPEAIwDegCN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AAIBQAACAgxBAAAAAVAAAQENAUIREhADESslIQEBIQEzAaYCT/7aAgb76gGysY8EHftUBaYAAAD//wDaAAAFDActECcBdgHuAWITBgAlAAAACbEAAbgBYrApKwD//wC6/+oEIAdTECcBdgGaAYgTBgBFAAAACbEAAbgBiLApKwD//wDaAAAFPActECcBdgI4AWITBgAnAAAACbEAAbgBYrApKwD//wCU/+oD9gdTECcBdgFyAYgTBgBHAAAACbEAAbgBiLApKwD//wDaAAAEDwctECcBdgGiAWITBgApAAAACbEAAbgBYrApKwD//wBuAAAC6AdTECcBdgEKAYgTBgBJAAAACbEAAbgBiLApKwD//wDaAAAGGActECcBdgKmAWITBgAwAAAACbEAAbgBYrApKwD//wC6AAAGlAWpECcBdgLU/94TBgBQAAAACbEAAbj/3rApKwD//wDaAAAErgctECcBdgHyAWITBgAzAAAACbEAAbgBYrApKwD//wC6/mgEGgWpECcBdgGY/94TBgBTAAAACbEAAbj/3rApKwD//wCQ/+oEjActECcBdgG8AWITBgA2AAAACbEAAbgBYrApKwD//wCO/+oDbAWpECcBdgEq/94TBgBWAAAACbEAAbj/3rApKwD//wBUAAAEYActECcBdgGIAWITBgA3AAAACbEAAbgBYrApKwD//wBQ//gC1AbdECcBdgDAARITBgBXAAAACbEAAbgBErApKwD//wBwAAAHkAe0ECcAQwJXAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAQwF+AE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAe0ECcAdgNGAdITBgA6AAAACbEAAbgB0rApKwD//wA0AAAGGgYwECcAdgJtAE4TBgBaAAAACLEAAbBOsCkrAAD//wBwAAAHkAcUECcAagIAAW4TBgA6AAAACbEAArgBbrApKwD//wA0AAAGGgWQECcAagEm/+oTBgBaAAAACbEAArj/6rApKwD//wAwAAAE9ge0ECcAQwDqAdITBgA8AAAACbEAAbgB0rApKwD//wBM/moEJAYwECcAQwCPAE4TBgBcAAAACLEAAbBOsCkrAAAAAQACAl4CFwLcAAMAHUAaAAABAQBLAAAAAU8CAQEAAUMAAAADAAMRAw8rEzUhFQICFQJe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AFoAXACCAIMAhACFAIYAhwCUAJUAlgCXAJgAmgCfALMAtAC1ALYAtwC4ALoAvwDAAMEAwgDEAMYA0ADnAOkBBgEIAQoBDgEPARABEQESARMBFgEYARoBJgE3ATkBOgFQAVIBXAFdAV4BXwFgAWIBagGEAYoBjAGOAZAAAgBGACQAJAABACYAJgACACcAJwADACkAKQAEACoAKgAFAC4ALgAGAC8ALwAHADIAMgADADMAMwAIADQANAADADUANQAJADcANwAKADkAOQALADoAOgAMADwAPAANAEQARAAOAEUARQAPAEgASAAQAEsASwARAFAAUQARAFIAUwAPAFkAWQASAFoAWgATAFwAXAAUAIIAhwABAJQAmAADAJoAmgADAJ8AnwANALMAswARALQAuAAPALoAugAPAL8AvwAUAMAAwAAPAMEAwQAUAMIAwgABAMQAxAABAMYAxgABANAA0AADAOcA5wARAOkA6QARAQYBBgARAQgBCAARAQoBCgARAQ4BDgADAQ8BDwAPARABEAADAREBEQAPARIBEgADARMBEwAPARYBFgAJARgBGAAJARoBGgAJASYBJgAKATcBNwATATkBOQAUAToBOgANAVABUAABAVIBUgABAVwBXAADAV0BXQAPAV4BXgADAV8BXwAPAWABYAAJAWIBYgAJAWoBagAKAYQBhAAPAYoBigATAYwBjAATAY4BjgATAZABkAAUAAIAbQAPAA8ADQARABEADgAkACQAAQAmACYAAgAqACoAAgAtAC0AAwAyADIAAgA0ADQAAgA2ADYABAA3ADcABQA4ADgABgA5ADkABwA6ADoACAA7ADsACQA8ADwACgBEAEQACwBGAEgADABSAFIADABUAFQADABYAFgADwBZAFkAEABaAFoAEQBcAFwAEgCCAIcAAQCJAIkAAgCUAJgAAgCaAJoAAgCbAJ4ABgCfAJ8ACgCiAKgACwCpAK0ADACyALIADAC0ALgADAC6ALoADAC7AL4ADwC/AL8AEgDBAMEAEgDCAMIAAQDDAMMACwDEAMQAAQDFAMUACwDGAMYAAQDHAMcACwDIAMgAAgDJAMkADADKAMoAAgDLAMsADADMAMwAAgDNAM0ADADOAM4AAgDPAM8ADADRANEADADVANUADADXANcADADZANkADADbANsADADdAN0ADADeAN4AAgDgAOAAAgDiAOIAAgDkAOQAAgEOAQ4AAgEPAQ8ADAEQARAAAgERAREADAESARIAAgETARMADAEUARQAAgEVARUADAEcARwABAEgASAABAEiASIABAEmASYABQEqASoABgErASsADwEsASwABgEtAS0ADwEuAS4ABgEvAS8ADwEwATAABgExATEADwEyATIABgEzATMADwE0ATQABgE1ATUADwE3ATcAEQE5ATkAEgE6AToACgFOAU4AAgFQAVAAAQFRAVEACwFSAVIAAQFTAVMACwFVAVUADAFXAVcADAFcAVwAAgFdAV0ADAFeAV4AAgFfAV8ADAFkAWQABgFlAWUADwFmAWYABgFnAWcADwFoAWgABAFqAWoABQGKAYoAEQGMAYwAEQGOAY4AEQGQAZAAEgABAAAACgAqADgAA0RGTFQAFGdyZWsAFGxhdG4AFAAEAAAAAP//AAEAAAABbGlnYQAIAAAAAQAAAAEABAAEAAAAAQAIAAEAGgABAAgAAgAGAAwBsgACAE8BsQACAEwAAQABAEk') format('truetype');
}
/* </style> */
// </style>



[link]

<tr class="link">
    <td><a href="%item-url%">%item-name%</a><p>%item-comment%</p></td>
    <td></td>
    <td>{.!link.}</td>
</tr>


[login]
{.if|{.=|{.cut|0|4|%version%.}|2.4.}|{:
    {.redirect|/~signin#%folder%.}
:}.}

[max contemp downloads]

{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~server-busy-page.html#{.filepath|%url%.}.}


[md5.js|public|no log]
var MD5 = function(d){var r = M(V(Y(X(d),
8*d.length)));return r.toLowerCase()};
function M(d){for(var _,m="0123456789ABCDEF",f="",r=0;r<d.length;r++)_=d.charCodeAt(r),
f+=m.charAt(_>>>4&15)+m.charAt(15&_);return f}
function X(d){for(var _=Array(d.length>>2),
m=0;m<_.length;m++)_[m]=0;for(m=0;m<8*d.length;m+=8)_[m>>5]|=(255&d.charCodeAt(m/8))<<m%32;return _}
function V(d){for(var _="",m=0;m<32*d.length;m+=8)_+=String.fromCharCode(d[m>>5]>>>m%32&255);return _}
function Y(d,_){d[_>>5]|=128<<_%32,d[14+(_+64>>>9<<4)]=_;
for(var m=1732584193,f=-271733879,r=-1732584194,i=271733878,n=0;n<d.length;n+=16)
{var h=m,t=f,g=r,e=i;
f=md5_ii(f=md5_ii(f=md5_ii(f=md5_ii(f=md5_hh(f=md5_hh(f=md5_hh(f=md5_hh(f=md5_gg(f=md5_gg(
f=md5_gg(f=md5_gg(f=md5_ff(f=md5_ff(f=md5_ff(f=md5_ff(f,r=md5_ff(r,i=md5_ff(i,m=md5_ff(
m,f,r,i,d[n+0],7,-680876936),f,r,d[n+1],12,-389564586),
m,f,d[n+2],17,606105819),i,m,d[n+3],22,-1044525330),
r=md5_ff(r,i=md5_ff(i,m=md5_ff(m,f,r,i,d[n+4],7,-176418897),
f,r,d[n+5],12,1200080426),m,f,d[n+6],17,-1473231341),
i,m,d[n+7],22,-45705983),
r=md5_ff(r,i=md5_ff(i,m=md5_ff(m,f,r,i,d[n+8],7,1770035416),
f,r,d[n+9],12,-1958414417),m,f,d[n+10],17,-42063),
i,m,d[n+11],22,-1990404162),
r=md5_ff(r,i=md5_ff(i,m=md5_ff(m,f,r,i,d[n+12],7,1804603682),
f,r,d[n+13],12,-40341101),m,f,d[n+14],17,-1502002290),
i,m,d[n+15],22,1236535329),
r=md5_gg(r,i=md5_gg(i,m=md5_gg(m,f,r,i,d[n+1],5,-165796510),
f,r,d[n+6],9,-1069501632),m,f,d[n+11],14,643717713),
i,m,d[n+0],20,-373897302),
r=md5_gg(r,i=md5_gg(i,m=md5_gg(m,f,r,i,d[n+5],5,-701558691),
f,r,d[n+10],9,38016083),m,f,d[n+15],14,-660478335),
i,m,d[n+4],20,-405537848),
r=md5_gg(r,i=md5_gg(i,m=md5_gg(m,f,r,i,d[n+9],5,568446438),
f,r,d[n+14],9,-1019803690),m,f,d[n+3],14,-187363961),
i,m,d[n+8],20,1163531501),
r=md5_gg(r,i=md5_gg(i,m=md5_gg(m,f,r,i,d[n+13],5,-1444681467),
f,r,d[n+2],9,-51403784),m,f,d[n+7],14,1735328473),
i,m,d[n+12],20,-1926607734),
r=md5_hh(r,i=md5_hh(i,m=md5_hh(m,f,r,i,d[n+5],4,-378558),
f,r,d[n+8],11,-2022574463),m,f,d[n+11],16,1839030562),
i,m,d[n+14],23,-35309556),
r=md5_hh(r,i=md5_hh(i,m=md5_hh(m,f,r,i,d[n+1],4,-1530992060),
f,r,d[n+4],11,1272893353),m,f,d[n+7],16,-155497632),
i,m,d[n+10],23,-1094730640),
r=md5_hh(r,i=md5_hh(i,m=md5_hh(m,f,r,i,d[n+13],4,681279174),
f,r,d[n+0],11,-358537222),m,f,d[n+3],16,-722521979),
i,m,d[n+6],23,76029189),
r=md5_hh(r,i=md5_hh(i,m=md5_hh(m,f,r,i,d[n+9],4,-640364487),
f,r,d[n+12],11,-421815835),m,f,d[n+15],16,530742520),
i,m,d[n+2],23,-995338651),
r=md5_ii(r,i=md5_ii(i,m=md5_ii(m,f,r,i,d[n+0],6,-198630844),
f,r,d[n+7],10,1126891415),m,f,d[n+14],15,-1416354905),
i,m,d[n+5],21,-57434055),
r=md5_ii(r,i=md5_ii(i,m=md5_ii(m,f,r,i,d[n+12],6,1700485571),
f,r,d[n+3],10,-1894986606),m,f,d[n+10],15,-1051523),
i,m,d[n+1],21,-2054922799),
r=md5_ii(r,i=md5_ii(i,m=md5_ii(m,f,r,i,d[n+8],6,1873313359),
f,r,d[n+15],10,-30611744),m,f,d[n+6],15,-1560198380),
i,m,d[n+13],21,1309151649),
r=md5_ii(r,i=md5_ii(i,m=md5_ii(m,f,r,i,d[n+4],6,-145523070),
f,r,d[n+11],10,-1120210379),m,f,d[n+2],15,718787259),
i,m,d[n+9],21,-343485551),
m=safe_add(m,h),f=safe_add(f,t),r=safe_add(r,g),i=safe_add(i,e)}
return Array(m,f,r,i)}
function md5_cmn(d,_,m,f,r,i){return safe_add(bit_rol(safe_add(safe_add(_,d),
safe_add(f,i)),r),m)}
function md5_ff(d,_,m,f,r,i,n){return md5_cmn(_&m|~_&f,d,_,r,i,n)}
function md5_gg(d,_,m,f,r,i,n){return md5_cmn(_&f|m&~f,d,_,r,i,n)}
function md5_hh(d,_,m,f,r,i,n){return md5_cmn(_^m^f,d,_,r,i,n)}
function md5_ii(d,_,m,f,r,i,n){return md5_cmn(m^(_|~f),d,_,r,i,n)}
function safe_add(d,_){var m=(65535&d)+(65535&_);return(d>>16)+(_>>16)+(m>>16)<<16|65535&m}
function bit_rol(d,_){return d<<_|d>>>32-_};

[nofiles]

<p>
    {.if|{.length|{.?search.}.}|
        {.!No search results.}|
        {.!Empty folder.}
    .}
</p>



[not found]

{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.redirect|/~404-page.html.}


[overload]

{.disconnect.}


[polyfills.js]
// Polyfills, targetting Otter Browser: https://otter-browser.org/

// Unfetch: https://github.com/developit/unfetch
self.fetch||(self.fetch=function(e,n){return n=n||{},new Promise(function(t,s){var r=new XMLHttpRequest,o=[],u=[],i={},a=function(){return{ok:2==(r.status/100|0),statusText:r.statusText,status:r.status,url:r.responseURL,text:function(){return Promise.resolve(r.responseText)},json:function(){return Promise.resolve(r.responseText).then(JSON.parse)},blob:function(){return Promise.resolve(new Blob([r.response]))},clone:a,headers:{keys:function(){return o},entries:function(){return u},get:function(e){return i[e.toLowerCase()]},has:function(e){return e.toLowerCase()in i}}}};for(var c in r.open(n.method||"get",e,!0),r.onload=function(){r.getAllResponseHeaders().replace(/^(.*?):[^\S\n]*([\s\S]*?)$/gm,function(e,n,t){o.push(n=n.toLowerCase()),u.push([n,t]),i[n]=i[n]?i[n]+","+t:t}),t(a())},r.onerror=s,r.withCredentials="include"==n.credentials,n.headers)r.setRequestHeader(c,n.headers[c]);r.send(n.body||null)})});
// Other
if (!NodeList.prototype.forEach) NodeList.prototype.forEach = Array.prototype.forEach;


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


[signin|public]

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
            <a class="invert" href="../">&lt;&lt; {.!Back.}</a>
            <a id="logout" class="invert" href="javascript:">{.!Logout.}</a>
        </p>
        <form id="changepwd">
            <p>{.!Change password.}</p>
            <p>{.!Warning: It's insecure to change password here.}</p>
            <input type="password" name="old" placeholder="{.!Old password.}" /><br />
            <input type="password" name="new" placeholder="{.!New password.}" /><br />
            <input type="password" name="verify" placeholder="{.!Enter again.}" /><br />
            <input type="submit" value="{.!OK.}" />
        </form>
        <script src="/~sha256.js"></script>
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
                                    dialog.alert('{.!You cannot change your password.}', () => location.href = location.hash.slice(1));
                                    break;
                                case 'Failed':
                                    dialog.alert('{.!Failed.}', () => location.href = location.hash.slice(1));
                                    break;
                                case 'Unauthorized':
                                    dialog.alert('{.!Old password is incorrect.}');
                                    this.passwords[0].value = '';
                                    break;
                            }
                        }
                        let submitString = '';
                        switch (window.HFS.version.slice(0, 3)) {
                            case '2.3':
                                submitString = `token=${HFS.sid}&old=${this.passwords[0].value}&new=${unescape(encodeURIComponent(this.passwords[1].value))}`;
                                break;
                            case '2.4':
                                submitString = `token=${HFS.sid}&old=${SHA256.hash(this.passwords[0].value)}&new=${btoa(unescape(encodeURIComponent(this.passwords[1].value)))}`;
                                break;
                        }
                        xhr.send(submitString);
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
    <section>
        <h1>Login</h1>
        <noscript>
            <p>{.!Javascript required.}</p>
        </noscript>
        <p>
            <a class="invert" href="../">&lt;&lt; {.!Back.}</a>
        </p>
        <form>
            <input type="text" name="username" placeholder="{.!Username.}" /><br />
            <input type="password" name="password" placeholder="{.!Password.}" /><br />
            <label><input type="checkbox" name="remember" /> {.!Remember credentials.}</label>
            <input type="submit" value="{.!Login.}" />
        </form>
        <script>
            class LoginManager {
                constructor() {
                    let hashScript = document.createElement('script');
                    this.hashMethod = 'plain';
                    switch (window.HFS.version.slice(0, 3)) {
                        case '2.3':
                            hashScript.src = '/~md5.js';
                            this.hashMethod = 'md5';
                            break;
                        case '2.4':
                            hashScript.src = '/~sha256.js';
                            this.hashMethod = 'sha256';
                            break;
                    }
                    document.head.appendChild(hashScript);
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
                    switch (this.hashMethod) {
                        case 'plain':
                            formdata.append('user', username);
                            formdata.append('password', password);
                            break;
                        case 'md5':
                            formdata.append('__USER', username);
                            if (typeof MD5 == 'undefined') {
                                formdata.append('__PASSWORD', password);
                            } else {
                                let hashed = MD5(MD5(password).toUpperCase()+token).toUpperCase();
                                formdata.append('__PASSWORD_MD5', hashed);
                            }
                            break;
                        case 'sha256':
                            formdata.append('user', username);
                            if (typeof SHA256 == 'undefined') {
                                formdata.append('password', password);
                            } else {
                                let hashed = SHA256.hash(SHA256.hash(password).toLowerCase() + token).toLowerCase();
                                formdata.append('passwordSHA256', hashed);
                            }
                            break;
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
                                // 2.3 OK redirects to previous page
                                location.href = location.hash.slice(1);
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



[takeback-filelist-main.js]
var __spreadArray = (this && this.__spreadArray) || function (to, from) {
    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)
        to[j] = from[i];
    return to;
};
var StaticsManager = /** @class */ (function () {
    function StaticsManager() {
        var _this = this;
        this.typeMap = {
            audio: ['.mp3', '.ogg', '.wav', '.m4a'],
            video: ['.mp4', '.ogv', '.mpv', '.webm'],
            image: ['.png', '.jpg', '.jpeg', '.gif', '.webp'],
            doc: ['.txt', '.html', '.htm'],
            playlist: ['.m3u', '.m3u8']
        };
        this.filelist = [];
        document.querySelectorAll('table#files tbody tr td:nth-child(1) a').forEach(function (element) { return _this.filelist.push(helper.uniformURI(element.href)); });
    }
    return StaticsManager;
}());
window.addEventListener('DOMContentLoaded', function () { return window.statics = new StaticsManager(); });
var Player = /** @class */ (function () {
    function Player() {
        var _this = this;
        this.lyricsArea = document.querySelector('section.lyrics');
        this.sequence = 'shuffle';
        this.playing = false;
        if (navigator.mediaSession) {
            navigator.mediaSession.setActionHandler('play', function () { return _this.play(); });
            navigator.mediaSession.setActionHandler('pause', function () { return _this.pause(); });
            navigator.mediaSession.setActionHandler('stop', function () { return _this.pause(); });
            navigator.mediaSession.setActionHandler('previoustrack', function () { return _this.play(-1); });
            navigator.mediaSession.setActionHandler('nexttrack', function () { return _this.play(1); });
        }
        this.songlist = window.statics.filelist.filter(function (filename) { return window.statics.typeMap['audio'].some(function (format) { return filename.toLowerCase().endsWith(format); }); });
        if (this.songlist.length != 0)
            $('#audioplayer').show();
        this.nowplaying = 0;
        this.songlistShuffled = this.songlist.sort(function (a, b) { return 0.5 - Math.random(); });
        document.getElementById('audioplayer').querySelectorAll('*[data-player], *[data-player-alt]').forEach(function (element) {
            switch (element.getAttribute('data-player')) {
                case 'next':
                    element.addEventListener('click', function () {
                        _this.play(1);
                    });
                    break;
                case 'pause':
                    element.addEventListener('click', function () {
                        _this.playing ? _this.pause() : _this.play();
                    });
                    break;
                case 'status':
                    _this.elemStatus = element;
                    break;
                case 'nowplaying':
                    _this.elemNowplaying = element;
                    break;
            }
            switch (element.getAttribute('data-player-alt')) {
                case 'prev':
                    element.addEventListener('contextmenu', function (event) {
                        event.preventDefault();
                        _this.play(-1);
                    });
                    break;
                case 'sequence':
                    element.addEventListener('contextmenu', function (event) {
                        event.preventDefault();
                        if (_this.sequence == 'shuffle') {
                            _this.sequence = 'sequence';
                        }
                        else {
                            _this.sequence = 'shuffle';
                        }
                    });
                    break;
            }
        });
    }
    Player.prototype.play = function (offset) {
        var _this = this;
        if (offset === void 0) { offset = 0; }
        if (offset != 0 || this.audio.src == '') {
            var count = this.nowplaying + offset;
            if (count < 0)
                count = this.songlist.length + count;
            else if (count >= this.songlist.length)
                count = count % this.songlist.length;
            this.nowplaying = count;
            // Webkit browsers cannot handle <video> <track> src change properly
            // So create a new <video> everytime play
            this.audio = document.createElement('video');
            this.audio.classList.add('lyrics');
            this.lyricsArea.querySelectorAll('video').forEach(function (e) { return e.remove(); });
            this.lyricsArea.appendChild(this.audio);
            this.audio.onended = function () { return _this.play(1); };
            this.audio.onerror = function () { return _this.play(1); };
            this.audio.src = this.sequence == 'shuffle' ? this.songlistShuffled[count] : this.songlist[count];
            this.addLyricsFor(this.audio.src);
        }
        this.audio.play();
        this.elemStatus.innerText = '{.!Playing:.}';
        this.elemNowplaying.innerText = helper.getFilename(this.audio.src);
        this.playing = true;
        if (navigator.mediaSession) {
            var _a = window.helper.getFilename(this.audio.src).split(' - ').reverse(), title = _a[0], artist = _a[1];
            var filename_1 = this.audio.src.split('.').slice(0, -1).join('.');
            var possibleArtworks = ['.jpg', '.png'].map(function (x) { return filename_1 + x; });
            var foundArtwork = possibleArtworks.filter(function (x) { return window.statics.filelist.indexOf(x) != -1; })[0];
            navigator.mediaSession.metadata = new MediaMetadata({
                title: title,
                artist: artist,
                artwork: foundArtwork ? [{
                        src: foundArtwork,
                        type: 'image/' + foundArtwork.split('.').slice(-1)[0],
                        sizes: '192x192'
                    }] : []
            });
        }
    };
    Player.prototype.pause = function () {
        this.audio.pause();
        this.elemStatus.innerText = '{.!Paused:.}';
        this.playing = false;
    };
    Player.prototype.convertLrcToVtt = function (lrc) {
        var lines = lrc.split('\n');
        return 'WEBVTT\n\n' + lines.map(function (item, index) {
            if (/^\[[a-z]{2}:(.*?)\]$/.test(item) || item.trim() == '')
                return ''; // Delete metadata
            item += lines[index + 1] || '[59:59.99]';
            item = item.replace(/^\[(.+?)\](.*?)\[(.+?)\](.*?)$/, '\n$10 --> $30\n$2\n').replace(/ ?\/ ?/g, '\n');
            return item;
        }).join('\n');
    };
    Player.prototype.addLyricsFor = function (file) {
        var _this = this;
        var lrcFile = helper.uniformURI(file.split('.').slice(0, -1).join('.') + '.lrc');
        if (window.statics.filelist.indexOf(lrcFile) == -1) {
            $(this.lyricsArea).hide();
            return;
        }
        fetch(lrcFile).then(function (r) { return r.text(); }).then(function (t) {
            var commonText = t.replace(/\r?\n/g, '\n');
            var vtt = _this.convertLrcToVtt(commonText);
            // let track = this.lyricsArea.querySelector('track');
            var track = document.createElement('track');
            track.kind = 'captions';
            track.default = true;
            _this.audio.appendChild(track);
            track.src = URL.createObjectURL(new Blob([vtt], { type: 'text/vtt;charset=utf-8' }));
            $(_this.lyricsArea).show();
        });
    };
    return Player;
}());
window.addEventListener('DOMContentLoaded', function () { return window.player = new Player(); });
var Previewer = /** @class */ (function () {
    // Also file control menu
    function Previewer() {
        var _this = this;
        this.selectedFiles = [];
        document.querySelectorAll('.part1 table#files tbody tr td:nth-child(1) a').forEach(function (element) {
            var path = helper.getPath(element.href); // href contains http://.../
            if (path.endsWith('/'))
                return;
            element.addEventListener('click', function (event) {
                event.preventDefault();
                event.cancelBubble = true; // prevent selecting item, just preview
                _this.preview(path);
                _this.selectedFiles = [path];
                _this.initMenu('file');
            });
        });
        document.querySelectorAll('table#files tbody tr').forEach(function (element) {
            element.addEventListener('click', function () {
                element.classList.toggle('selected');
                _this.selectedFiles = __spreadArray([], document.querySelectorAll('table#files tbody tr.selected')).map(function (x) { return helper.getPath(x.querySelector('td:nth-child(1) a').href); });
                _this.initMenu('selections');
            });
        });
        $('#preview').show();
        document.getElementById('preview').querySelectorAll('*[data-preview]').forEach(function (element) {
            switch (element.getAttribute('data-preview')) {
                case 'close':
                    element.addEventListener('click', function () {
                        _this.close();
                        _this.initMenu();
                    });
                    break;
                case 'title':
                    _this.elemTitle = element;
                    break;
                case 'menu':
                    _this.elemMenu = element;
                    break;
                case 'content':
                    _this.elemContent = element;
                    break;
            }
        });
        this.elemTitle.innerText = helper.getFilename(window.HFS.folder.slice(0, -1));
        this.initMenu();
    }
    Previewer.prototype.delete = function (items) {
        window.dialog.confirm('{.!Delete @items@?.}'.replace('@items@', items.map(function (x) { return helper.getFilename(x); }).join('; ')), function () {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', window.HFS.folder);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = function () {
                window.dialog.alert('{.!Success.}', function () { return location.href = (items[0] == window.HFS.folder ? '../' : './'); });
            };
            xhr.send("action=delete&selection=" + items.join('&selection='));
        });
    };
    Previewer.prototype.move = function (items) {
        window.dialog.prompt('{.!Move items to:.}', function (target) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.move');
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = function () {
                window.dialog.alert('{.!Success.}', function () { return location.href = (items[0] == window.HFS.folder ? '../' : './'); });
            };
            xhr.send("path=" + helper.getDirname(items[0]) + "&from=" + items.map(function (x) { return helper.getFilename(x); }).join(':') + "&to=" + target + "&token=" + window.HFS.sid);
        });
    };
    Previewer.prototype.rename = function (items) {
        if (items.length > 1) {
            window.dialog.alert('{.!Can only rename 1 file.}');
            return;
        }
        window.dialog.prompt('{.!Rename item to:.}', function (target) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.rename');
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = function () {
                window.dialog.alert('{.!Success.}', function () { return location.href = (items[0] == window.HFS.folder ? '../' : './'); });
            };
            xhr.send("from=" + items.join(':') + "&to=" + target + "&token=" + window.HFS.sid);
        });
    };
    Previewer.prototype.comment = function (items) {
        window.dialog.prompt('{.!Enter comment:.}', function (comment) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', './?mode=section&id=ajax.comment');
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
            xhr.onload = function () {
                window.dialog.alert('{.!Success.}', function () { return location.href = (items[0] == window.HFS.folder ? '../' : './'); });
            };
            xhr.send("files=" + items.join(':') + "&text=" + comment + "&token=" + window.HFS.sid);
        });
    };
    Previewer.prototype.archive = function (items) {
        var form = document.createElement('form');
        form.style.display = 'none';
        form.action = './?mode=archive&recursive';
        form.method = 'POST';
        items.forEach(function (path) {
            var input = document.createElement('input');
            form.append(input);
            input.type = 'hidden';
            input.name = 'selection';
            input.value = helper.getFilename(path);
        });
        document.body.appendChild(form);
        form.submit();
    };
    Previewer.prototype.initMenu = function (type) {
        var _this = this;
        if (type === void 0) { type = 'folder'; }
        function createButton(name, action) {
            var a = document.createElement('a');
            var span = document.createElement('span');
            span.classList.add('menuitem');
            span.innerText = name;
            a.addEventListener('click', action.bind(this));
            a.href = 'javascript:';
            a.style.margin = '0 0.2em';
            a.appendChild(span);
            return a;
        }
        var mark = document.createElement('span');
        mark.style.margin = '0 0.2em';
        var menu = [mark];
        switch (type) {
            case 'folder':
                mark.innerText = '{.!Folder:.}';
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', function () { return _this.delete([window.HFS.folder]); }));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', function () { return _this.move([window.HFS.folder]); }));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', function () { return _this.rename([window.HFS.folder]); }));
                    }
                    if (window.HFS.can_comment) {
                        menu.push(createButton('{.!Comment.}', function () { return _this.comment([window.HFS.folder]); }));
                    }
                }
                break;
            case 'file':
                mark.innerText = '{.!File:.}';
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', function () { return _this.delete(_this.selectedFiles); }));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', function () { return _this.move(_this.selectedFiles); }));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', function () { return _this.rename(_this.selectedFiles); }));
                    }
                    if (window.HFS.can_comment) {
                        menu.push(createButton('{.!Comment.}', function () { return _this.comment(_this.selectedFiles); }));
                    }
                }
                break;
            case 'selections':
                mark.innerText = '{.!Selections:.}';
                menu.push(createButton('{.!Select All.}', function () { return document.querySelectorAll('table#files tbody tr').forEach(function (e) { return e.classList.add('selected'); }); }));
                menu.push(createButton('{.!Invert.}', function () { return document.querySelectorAll('table#files tbody tr').forEach(function (e) { return e.classList.toggle('selected'); }); }));
                menu.push(createButton('{.!Mask.}', function () { return window.dialog.prompt('{.!Enter mask to select.}', function (mask) {
                    var isRegex = /^\/.+\/$/.test(mask);
                    if (isRegex)
                        mask = mask.slice(1, -1);
                    else
                        mask = mask.replace(/\*/g, '.*').replace(/\?/, '.?');
                    document.querySelectorAll('table#files tbody tr td a').forEach(function (a) {
                        if (helper.uniformURI(a.href).match(new RegExp(mask)) !== null) {
                            a.parentElement.parentElement.classList.add('selected');
                        }
                        else {
                            a.parentElement.parentElement.classList.remove('selected');
                        }
                    });
                }); }));
                if (window.HFS.can_delete) {
                    menu.push(createButton('{.!Delete.}', function () { return _this.delete(_this.selectedFiles); }));
                    if (window.HFS.can_move) {
                        menu.push(createButton('{.!Move.}', function () { return _this.move(_this.selectedFiles); }));
                    }
                    if (window.HFS.can_rename) {
                        menu.push(createButton('{.!Rename.}', function () { return _this.rename(_this.selectedFiles); }));
                    }
                    if (window.HFS.can_comment) {
                        menu.push(createButton('{.!Comment.}', function () { return _this.comment(_this.selectedFiles); }));
                    }
                }
                menu.push(createButton('{.!Archive.}', function () { return _this.archive(_this.selectedFiles); }));
                break;
        }
        this.elemMenu.querySelectorAll('*').forEach(function (e) { return e.remove(); });
        if (menu.length > 1)
            for (var _i = 0, menu_1 = menu; _i < menu_1.length; _i++) {
                var i = menu_1[_i];
                this.elemMenu.appendChild(i);
            }
    };
    Previewer.prototype.close = function () {
        this.elemContent.querySelectorAll('*').forEach(function (e) { return e.remove(); });
        this.elemTitle.innerText = helper.getFilename(window.HFS.folder.slice(0, -1));
    };
    Previewer.prototype.convertSrtToVtt = function (srt) {
        return 'WEBVTT\n\n' + srt.replace(/\{\\([ibu])\}/g, '</$1>').replace(/\{\\([ibu])1\}/g, '<$1>').replace(/\{([ibu])\}/g, '<$1>').replace(/\{\/([ibu])\}/g, '</$1>').replace(/(\d\d:\d\d:\d\d),(\d\d\d)/g, '$1.$2').concat('\n\n');
    };
    Previewer.prototype.preview = function (url) {
        var _this = this;
        this.close();
        this.elemTitle.innerText = helper.getFilename(url);
        var type = 'unknown';
        for (var i in window.statics.typeMap) {
            if (window.statics.typeMap[i].some(function (format) { return url.toLowerCase().endsWith(format); })) {
                type = i;
                break;
            }
        }
        var wrapperContent = document.createElement('div');
        var wrapperActions = document.createElement('div');
        switch (type) {
            case 'audio':
                var audio = document.createElement('audio');
                audio.controls = true;
                audio.src = url;
                wrapperContent.appendChild(audio);
                audio.play();
                var a0 = document.createElement('a');
                a0.href = 'javascript:';
                a0.innerText = '[ {.!Move to mini player.} ]';
                a0.addEventListener('click', function () {
                    _this.close.bind(_this)();
                    window.player.sequence = 'shuffle';
                    window.player.nowplaying = 0;
                    var number = window.player.songlistShuffled.map(function (x) { return helper.getPath(x); }).indexOf(url);
                    window.player.play(number);
                });
                wrapperActions.appendChild(a0);
                break;
            case 'video':
                var video = document.createElement('video');
                video.controls = true;
                video.src = url;
                wrapperContent.appendChild(video);
                video.play();
                var srtName = video.src.split('.').slice(0, -1).join('.') + '.srt';
                var vttName = video.src.split('.').slice(0, -1).join('.') + '.vtt';
                if (window.statics.filelist.indexOf(vttName) != -1) {
                    var track = document.createElement('track');
                    track.default = true;
                    track.kind = 'captions';
                    track.src = vttName;
                    video.appendChild(track);
                }
                else if (window.statics.filelist.indexOf(srtName) != -1) {
                    var track_1 = document.createElement('track');
                    track_1.default = true;
                    track_1.kind = 'captions';
                    fetch(srtName).then(function (r) { return r.text(); }).then(function (t) {
                        var commonText = t.replace(/\r?\n/g, '\n');
                        var vtt = _this.convertSrtToVtt(commonText);
                        track_1.src = URL.createObjectURL(new Blob([vtt], { type: 'text/vtt;charset=utf-8' }));
                    });
                    video.appendChild(track_1);
                }
                break;
            case 'image':
                var img = document.createElement('img');
                img.src = url;
                wrapperContent.appendChild(img);
                var a1 = document.createElement('a');
                a1.href = 'javascript:';
                a1.innerText = '[ {.!Start Slideshow.} ]';
                a1.addEventListener('click', function () {
                    _this.close.bind(_this)();
                    _this.slideshow();
                });
                wrapperActions.appendChild(a1);
                break;
            case 'doc':
                var iframe = document.createElement('iframe');
                iframe.src = url;
                wrapperContent.appendChild(iframe);
                break;
            case 'playlist':
                var span1 = document.createElement('span');
                span1.innerText = '{.!This is a playlist..}';
                wrapperContent.appendChild(span1);
                var a2 = document.createElement('a');
                a2.href = 'javascript:';
                a2.innerText = '[ {.!Play.} ]';
                a2.addEventListener('click', function () {
                    window.player.sequence = 'sequence';
                    window.player.nowplaying = -1;
                    fetch(url).then(function (r) { return r.text(); }).then(function (t) {
                        window.player.songlist = t.split('\n').map(function (x) {
                            return helper.uniformURI(((x[0] == '\'' && x.slice(-1) == '\'') || (x[0] == '"' && x.slice(-1) == '"')) ? x.slice(1, -1) : x);
                        }).filter(function (x) { return x.trim() != ''; });
                        window.player.play(1);
                        _this.close.bind(_this)();
                    });
                });
                wrapperActions.appendChild(a2);
                break;
            default:
                var span0 = document.createElement('span');
                span0.classList.add('nopreview');
                span0.innerText = '{.!No preview available.}';
                wrapperContent.appendChild(span0);
                break;
        }
        this.elemContent.appendChild(wrapperContent);
        var download = document.createElement('a');
        var span = document.createElement('span');
        span.innerText = '[ {.!Download.} ]';
        download.appendChild(span);
        download.classList.add('download');
        download.href = url;
        download.download = helper.getFilename(url);
        wrapperActions.appendChild(download);
        this.elemContent.appendChild(wrapperActions);
    };
    Previewer.prototype.slideshow = function () {
        var pictures = window.statics.filelist.filter(function (x) { return window.statics.typeMap['image'].some(function (y) { return x.endsWith(y); }); });
        var slideshow = document.querySelector('.slideshow');
        var imgs = slideshow.querySelectorAll('img');
        var n = 0;
        document.body.style.overflow = 'hidden';
        function switchslide() {
            imgs[1].src = pictures[n];
            imgs[1].style.opacity = '1';
            setTimeout(function () {
                imgs[0].src = pictures[n++];
                n %= pictures.length;
                imgs[1].style.opacity = '0';
            }, 1000);
        }
        var interval = setInterval(switchslide, 5000);
        switchslide();
        slideshow.oncontextmenu = function (event) {
            event.preventDefault();
            $(slideshow).hide();
            document.body.style.overflow = '';
            clearInterval(interval);
        };
        $(slideshow).show();
    };
    return Previewer;
}());
window.addEventListener('DOMContentLoaded', function () { return window.previewer = new Previewer(); });
var ThumbsManager = /** @class */ (function () {
    function ThumbsManager() {
        this.buttonShowThumb = document.getElementById('showthumb');
        this.buttonShowThumb.addEventListener('click', this.showThumb.bind(this));
        if (window.statics.filelist.some(function (x) { return window.statics.typeMap['image'].some(function (y) { return x.endsWith(y); }); })) {
            $(this.buttonShowThumb).show();
        }
        ;
        this.shown = false;
    }
    ThumbsManager.prototype.showThumb = function () {
        if (this.shown)
            return;
        this.shown = true;
        var items = document.querySelectorAll('table#files tbody tr td:nth-child(1)');
        var imgs = [];
        items.forEach(function (element) {
            var a = element.querySelector('a');
            if (window.statics.typeMap['image'].some(function (x) { return a.href.toLowerCase().endsWith(x); })) {
                var img = document.createElement('img');
                img.classList.add('thumb');
                // img.loading = 'lazy';    // Breaks our purpose
                img.setAttribute('data-src', a.href);
                element.prepend(img);
                imgs.push(img);
            }
        });
        var count = 0;
        function showNextThumb() {
            imgs[count].src = imgs[count].getAttribute('data-src');
            if (imgs[count + 1]) {
                imgs[count].addEventListener('load', function () {
                    setTimeout(showNextThumb, 181);
                });
            }
            count++;
        }
        showNextThumb();
    };
    return ThumbsManager;
}());
window.addEventListener('DOMContentLoaded', function () { return window.thumbs_manager = new ThumbsManager(); });



[takeback-filelist.css|public|no log|cache]

/* <style> /**/
a:link, a:visited {
    color:#fff;
}
a:hover {
    color: #ff4954;background: transparent;
}
a:active {
    color: white;
}

a.invert:link, a.invert:visited {
    color: #ff4954;
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
    border-radius: 50%;
background: #b9b9b985;}
nav {
    display: flex;
    grid-area: nav;
    height: 60px;
    width: 100%;
    background: #1b1b1b;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    position: fixed;z-index: 1;
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
.assigner {
    width: 100%;
    display: flex;
    justify-content: space-around;
    height: 30px;
    background: #fff;
    border-radius: 5px;
    margin: auto;
    color: #000;
    position: fixed;
    top: 90px;
    z-index: 1;
}
.assigner p{
    display: block;
margin-top: -3px;
}
.assigner .file-n {
    display: flex;width: 75%;
}
.assigner .file-n a svg{position: relative;top: 3px;left: 3px;}.assigner .file-m a svg{position: relative;top: 3px;}.assigner .file-s a svg{position: relative;top: 3px;}
.assigner .file-m{
    width: 15%;display: flex;
}
.assigner .file-s{
    width: 10%;display: flex;
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

.log-mang{text-align: center;grid-area: part1;}
.log-mang .log-usr span{font-size: 24px;font-family: sans-serif;font-weight: bold;color: #9400ff;}
.log-mang .log-usr  #logout{color: #ff4954;font-family: sans-serif;}
#changepwd p{font-weight: bold;font-size: 24px;color: #55ff46;}
.log-in{grid-area: part1;text-align: center;}
.log-in h1{color: #55ff49;}
.log-in form input{padding: 8px;font-size: 16px;margin: 20px 0;background: #fff;border-radius: 5px;border: 1px solid #fff;}
#changepwd input{padding: 8px;font-size: 16px;margin: 20px 0;background: #fff;border-radius: 5px;border: 1px solid #fff;}
.additional-panel {
    height: 30px;
    display: flex;
    position: fixed;
    width: 100%;
    top: 60px;
    z-index: 1;
    background: #1b1b1b;
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
    display: block;
    cursor: pointer;
}
@media only screen and (max-width: 850px) {
    section#tooltip {
        bottom: unset;
        top: 1.8em;
    }
    nav .s-div .search-control{width: 180px;}
    nav .login-con{margin-right: 6px;}
    span.login-con > a{margin-left: 2px;}
    nav .logo{margin: 0 0 0 10px;}
    .assigner .file-n{width: 60%;}
}

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
.part0 p {
    margin: 0;
}
.part0 p a span {
    color: green;
    animation: blinkgreen 5s ease-in-out 0s infinite;
}
.part1 {
    width: 100%;
    overflow-x: auto;position: relative;top: 60px;
}.part1 > main:nth-child(3){
    display: block;
margin: 60px 0 10px 0;
}
.part1 table#files {
    min-width:100%;
    margin: auto;
    white-space: nowrap;
    /* position:; */
    top: 30px;
}
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
.part1 table#files td:nth-child(3) {
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
    outline: 1px solid transparent;
    transition: all 0.3s;
}
.part1 table#files tbody tr p {
    margin: 0;
    margin-left: 1em;
    border-left: 1px solid white;
    padding-left: 1em;
}
.part1 table#files tbody tr:hover {
    outline: 1px solid #ff4954;
    border-radius: 5px;
}
.part1 table#files tbody tr.selected {
    outline: 1px solid #b072fb;
    border-radius: 5px;
}
.part1 table#files .folder td:nth-child(3),
.part1 table#files .link td:nth-child(3) {
    color: gray;
    font-style: italic;
    text-align: center;
}
.part1 table#files tr td {
    height: 32px;
}
.part2{margin-top: 50PX;}
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

section.lyrics {    /* Same as tooltip */
    position: fixed;
    bottom: 3.6em;
    width: 100%;
    height: 3.6em;
    border-top: 1px solid currentColor;
    border-bottom: 1px solid currentColor;
    background-color: rgba(0, 0, 0, 0.8);
    overflow: hidden;
}
video::cue {
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
    font-size: 1em;
    font-family: 'Takeback-Define-Font', 'Monda', sans-serif;
    overflow: visible;
}
video.lyrics {
    width: 100%;
    height: 20em;
    position: absolute;
    display: block;
    left: 0;
    bottom: 0;
}

@media (max-width: 950px) {
    body {
        font-size: 1em;
    }
    .part3 .left {
        bottom: 3.6em;
        overflow-x: visible;
        white-space: nowrap;
    }
    .part3 .right {
        min-width: unset;
        width: 100%;
    }
    section.lyrics {
        bottom: unset;
        top: 1.8em;
    }
}
div#files {
    display: flex;
    flex-wrap: wrap;
    align-content: center;
    justify-content: space-around;
    overflow-x: hidden;
}
div#files>div {
    width: 8em;
    height: 6em;
}
div#files a::before {
    display: block;
    transform: scale(2);
    height: 2.4em;
    transform-origin: top;
}
/* Folder */
table#files a[href$="/"]::before {
    content: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
    top: 3px;
    display: inline-block;
    position: relative;
    width: 1.75em;
    text-align: center;
}
div#files a[href$="/"]::before {
    content: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M12.414 5H21a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h7.414l2 2z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
}

/* Unknown File */
td a::before {
    content: "\1f4c4";
    color: #BCC;
    display: inline-block;
    position: relative;
    width: 1.75em;
    text-align: center;
}
div>a::before {
    content: "\1f4c4";
}

/* Other */
td a[href$=";"i]::before,    /* javascript: ...; */
td a[href$=":"i]::before,    /* javascript: */
td a[href*="?"i]::before {
    content: none;
}
div a[href$=";"i]::before,
div a[href$=":"i]::before,
div a[href*="?"i]::before {
    content: none;
}

/* Picture */
a[href$=".jpg"i]::before,
a[href$=".webp"i]::before,
a[href$=".png"i]::before,
a[href$=".gif"i]::before {
    content: "\1f4f7";
    color: black
}

/* Working Picture (Photoshop & GIMP) */
a[href$=".psd"i]::before,
a[href$=".xcf"i]::before {
    content: "📸";
    color: #5AE
}

/* Audio/Music */
a[href$=".mp3"i]::before,
a[href$=".aac"i]::before,
a[href$=".m4a"i]::before,
a[href$=".wav"i]::before,
a[href$=".ogg"i]::before {
    content: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M16 2l5 5v14.008a.993.993 0 0 1-.993.992H3.993A1 1 0 0 1 3 21.008V2.992C3 2.444 3.445 2 3.993 2H16zm-5 10.05a2.5 2.5 0 1 0 2 2.45V10h3V8h-5v4.05z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
    position: relative;top: 3px;
}

/* Video */
a[href$=".mp4"i]::before,
a[href$=".avi"i]::before,
a[href$=".webm"i]::before,
a[href$=".ogv"i]::before,
a[href$=".flv"i]::before,
a[href$=".mkv"i]::before {
    content: "\1f4fa";
    position: relative;top: 3px;
}

/* Compressed/Storage Pack */
a[href$=".tar"i]::before,
a[href$=".gz"i]::before,
a[href$=".xz"i]::before,
a[href$=".rar"i]::before,
a[href$=".7z"i]::before,
a[href$=".zip"i]::before {
    content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M10 2v2h2V2h8.007c.548 0 .993.444.993.992v18.016a1 1 0 0 1-.993.992H3.993A.993.993 0 0 1 3 21.008V2.992A1 1 0 0 1 3.993 2H10zm2 2v2h2V4h-2zm-2 2v2h2V6h-2zm2 2v2h2V8h-2zm-2 2v2h2v-2h-2zm2 2v2h-2v3h4v-5h-2z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
    position: relative;top: 3px;
}

/* Installation Pack */
a[href$=".msi"i]::before,
a[href$=".tar.gz"i]::before,
a[href$=".deb"i]::before,
a[href$=".rpm"i]::before {
    content: "📦";
    color: brown
}

/* Executable/Script */
a[href$=".exe"i]::before,
a[href$=".vbs"i]::before,
a[href$=".bat"i]::before,
a[href$=".sh"i]::before,
a[href$=".ps1"i]::before,
a[href$=".pyc"i]::before,
a[href$=".apk"i]::before {
    content: "\1f537";
    color: #5AE
}

/* Code */
a[href$=".c"i]::before,
a[href$=".cpp"i]::before,
a[href$=".h"i]::before,
a[href$=".cxx"i]::before,
a[href$=".gcc"i]::before,
a[href$=".py"i]::before,
a[href$=".js"i]::before {
    content: "⌨";
    position: relative;top: 3px;
}

/* Working Document */
a[href$=".rtf"i]::before,
a[href$=".doc"i]::before,
a[href$=".docx"i]::before,
a[href$=".odt"i]::before,
a[href$=".xls"i]::before,
a[href$=".xlsx"i]::before,
a[href$=".ods"i]::before,
a[href$=".ppt"i]::before,
a[href$=".pptx"i]::before,
a[href$=".odp"i]::before {
    content: "📝";
    position: relative;top: 3px;
}
a[href$=".pdf"i]::before {
    content: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 384 512'%3E%3Cdefs%3E%3Cstyle%3E.fa-secondary%7Bopacity:0.1%7D%3C/style%3E%3C/defs%3E%3Cpath d='M384 128H272a16 16 0 0 1-16-16V0H24A23.94 23.94 0 0 0 0 23.88V488a23.94 23.94 0 0 0 23.88 24H360a23.94 23.94 0 0 0 24-23.88V128zM280.51 446.09A12 12 0 0 1 274 448h-34.9a12 12 0 0 1-10.6-6.3C208.9 405.5 192 373 192 373c-6.4 14.8-10 20-36.6 68.8a11.89 11.89 0 0 1-10.5 6.3H110a12 12 0 0 1-10.1-18.5l60.3-93.5-60.3-93.5a12 12 0 0 1 10.1-18.5h34.8a12 12 0 0 1 10.6 6.3c26.1 48.8 20 33.6 36.6 68.5 0 0 6.1-11.7 36.6-68.5a12 12 0 0 1 10.6-6.3H274a11.93 11.93 0 0 1 10.1 18.4L224 336l60.1 93.5a12 12 0 0 1-3.59 16.59z' class='fa-secondary' fill='%23fff'/%3E%3Cpath class='fa-primary' d='M377 105L279.1 7a24 24 0 0 0-17-7H256v112a16 16 0 0 0 16 16h112v-6.1a23.9 23.9 0 0 0-7-16.9zM224 336l60.1-93.5a11.93 11.93 0 0 0-10.1-18.4h-34.8a12 12 0 0 0-10.6 6.3c-30.5 56.8-36.6 68.5-36.6 68.5-16.6-34.9-10.5-19.7-36.6-68.5a12 12 0 0 0-10.6-6.3H110a12 12 0 0 0-10.1 18.5l60.3 93.5-60.3 93.5a12 12 0 0 0 10.1 18.5h34.9a11.89 11.89 0 0 0 10.5-6.3c26.6-48.8 30.2-54 36.6-68.8 0 0 16.9 32.5 36.5 68.7a12 12 0 0 0 10.6 6.3H274a12 12 0 0 0 10.1-18.5z' fill='%23000'/%3E%3C/svg%3E");
    position: relative;top: 3px;
}


/* E-Books */
a[href$=".epub"i]::before {
    content: "📕";
    position: relative;top: 3px;
}

/* Other Text */
a[href$=".txt"i]::before,
a[href$=".ini"i]::before,
a[href$=".htm"i]::before,
a[href$=".html"i]::before,
a[href$=".cfg"i]::before,
a[href$=".json"i]::before,
a[href$=".m3u"i]::before,
a[href$=".m3u8"i]::before,
a[href$=".lrc"i]::before {
    content:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M21 9v11.993A1 1 0 0 1 20.007 22H3.993A.993.993 0 0 1 3 21.008V2.992C3 2.455 3.447 2 3.998 2H14v6a1 1 0 0 0 1 1h6zm0-2h-5V2.003L21 7zM8 7v2h3V7H8zm0 4v2h8v-2H8zm0 4v2h8v-2H8z' fill='rgba(255,255,255,1)'/%3E%3C/svg%3E");
    position: relative;top: 3px;
}

/* Flash */
a[href$=".swf"i]::before {
    content: "⚡";
    color: gold;
}

/* Icon */
a[href$=".ico"i]::before {
    content: "🥚";
    position: relative;top: 3px;
}

/* (Data) Image */
a[href$=".iso"i]::before,
a[href$=".img"i]::before,    /* '.img' is a floppy💾 image💿 */
a[href$=".dda"i]::before {
    content: "💿";
    position: relative;top: 3px;
}

/* Link */
table#files a[href^="ftp://"]::before,
table#files a[href^="file://"]::before,
table#files a[href^="tcp://"]::before,
table#files a[href^="udp://"]::before,
table#files a[href^="rtmp://"]::before,
table#files a[href^="rtsp://"]::before,
table#files a[href^="http://"]::before,
table#files a[href^="https://"]::before {
    content: "🌎";
    position: relative;top: 3px;
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
/* </style> */


[takeback-filelist.js|no log|public|cache]
{.comment| Here you can include other scripts for semantic scripting .}

{.$takeback-filelist-main.js.}


[takeback-general-main.js]
var Helper = /** @class */ (function () {
    function Helper() {
    }
    Helper.prototype.uniformURI = function (str) {
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent
        return decodeURIComponent(str).replace(/#/g, '%23');
    };
    Helper.prototype.getFilename = function (path) {
        return this.uniformURI(path.split('/').slice(-1)[0]);
    };
    Helper.prototype.getDirname = function (path) {
        return this.uniformURI(path.split('/').slice(0, -1).join('/') + '/');
    };
    Helper.prototype.getPath = function (url) {
        return this.uniformURI('/' + url.split('/').slice(3).join('/'));
    };
    return Helper;
}());
var helper = new Helper();
var Animator = /** @class */ (function () {
    function Animator(selector) {
        if (typeof selector == 'string') {
            this.elements = document.querySelectorAll(selector);
        }
        else {
            this.elements = [selector];
        }
        this.FRAME = 1000 / 60;
        // Edit CSS for controlling how to animate
        this.classShow = 'animator-show';
        this.classHide = 'animator-hide';
    }
    Animator.prototype.hide = function (timeout, callbackfn) {
        var _this = this;
        if (timeout === void 0) { timeout = 200; }
        if (callbackfn === void 0) { callbackfn = function () { return undefined; }; }
        this.elements.forEach(function (element) {
            element.style.transition = "all " + timeout + "ms";
            setTimeout(function () {
                element.classList.add(_this.classHide);
                element.classList.remove(_this.classShow);
            }, _this.FRAME);
            setTimeout(function () {
                element.style.transition = '';
                element.style.display = 'none';
                callbackfn();
            }, timeout - 1);
        });
    };
    Animator.prototype.show = function (timeout, callbackfn) {
        var _this = this;
        if (timeout === void 0) { timeout = 200; }
        if (callbackfn === void 0) { callbackfn = function () { return undefined; }; }
        this.elements.forEach(function (element) {
            element.classList.add(_this.classHide);
            element.style.transition = "all " + timeout + "ms";
            element.style.display = '';
            setTimeout(function () {
                element.classList.remove(_this.classHide);
                element.classList.add(_this.classShow);
            }, _this.FRAME);
            setTimeout(function () {
                element.style.transition = '';
                element.style.display = '';
                callbackfn();
            }, timeout);
        });
    };
    return Animator;
}());
function AnimatorConstructor(selector) { return new Animator(selector); }
var $ = AnimatorConstructor;
var TooltipManager = /** @class */ (function () {
    function TooltipManager() {
        var _this = this;
        this.elemTooltip = document.getElementById('tooltip');
        document.querySelectorAll('*[data-tooltip]').forEach(function (element) {
            element.addEventListener('mouseover', function () { return _this.show(element.getAttribute('data-tooltip')); });
            element.addEventListener('mouseout', function () { return _this.hide(); });
        });
    }
    TooltipManager.prototype.show = function (message) {
        this.elemTooltip.innerText = message;
        $(this.elemTooltip).show();
    };
    TooltipManager.prototype.hide = function () {
        $(this.elemTooltip).hide();
    };
    return TooltipManager;
}());
window.addEventListener('DOMContentLoaded', function () { return window.tooltip_manager = new TooltipManager(); });
var Dialog = /** @class */ (function () {
    function Dialog() {
        this.sectionDialog = document.getElementById('dialog');
        this.elemDialog = document.createElement('div');
        $(this.elemDialog).hide();
        this.elemDialog.classList.add('dialog');
        this.elemText = document.createElement('p');
        var hr = document.createElement('hr');
        this.elemActions = document.createElement('p');
        this.elemActions.style.display = 'flex';
        this.elemActions.style.justifyContent = 'space-around';
        this.elemDialog.appendChild(this.elemText);
        this.elemDialog.appendChild(hr);
        this.elemDialog.appendChild(this.elemActions);
        this.sectionDialog.appendChild(this.elemDialog);
        this.close();
    }
    Dialog.prototype.clearActions = function () {
        this.elemActions.querySelectorAll('*').forEach(function (e) { return e.remove(); });
    };
    Dialog.prototype.showDialog = function () {
        this.sectionDialog.style.top = '0';
        this.sectionDialog.style.opacity = '1';
        $(this.elemDialog).show();
    };
    Dialog.prototype.close = function () {
        var _this = this;
        this.sectionDialog.style.opacity = '0';
        $(this.elemDialog).hide(undefined, function () { return _this.sectionDialog.style.top = '200%'; });
    };
    Dialog.prototype.alert = function (message, callbackfn) {
        var _this = this;
        if (callbackfn === void 0) { callbackfn = function () { return undefined; }; }
        function done() {
            this.close();
            callbackfn();
        }
        this.elemDialog.onkeyup = function (event) {
            if (event.key == 'Enter')
                done.bind(_this)();
        };
        this.elemText.innerText = message;
        this.clearActions();
        var ok = document.createElement('a');
        ok.innerText = '{.!OK.}';
        ok.href = 'javascript:';
        ok.classList.add('invert');
        ok.addEventListener('click', done.bind(this));
        this.elemActions.appendChild(ok);
        this.showDialog();
    };
    Dialog.prototype.confirm = function (message, callbackfn) {
        var _this = this;
        if (callbackfn === void 0) { callbackfn = function () { return undefined; }; }
        function done() {
            this.close();
            callbackfn();
        }
        this.elemDialog.onkeyup = function (event) {
            if (event.key == 'Enter')
                done.bind(_this)();
        };
        this.elemText.innerText = message;
        this.clearActions();
        var ok = document.createElement('a');
        ok.innerText = '{.!OK.}';
        ok.href = 'javascript:';
        ok.classList.add('invert');
        ok.addEventListener('click', done.bind(this));
        this.elemActions.appendChild(ok);
        var cancel = document.createElement('a');
        cancel.innerText = '{.!Cancel.}';
        cancel.href = 'javascript:';
        cancel.classList.add('invert');
        cancel.addEventListener('click', function () {
            _this.close();
        });
        this.elemActions.appendChild(cancel);
        this.showDialog();
    };
    Dialog.prototype.prompt = function (message, callbackfn) {
        var _this = this;
        if (callbackfn === void 0) { callbackfn = function (input) { return input; }; }
        function done() {
            this.close();
            callbackfn(elemInput.value);
        }
        this.elemText.innerText = message;
        var elemInput = document.createElement('input');
        var br = document.createElement('br');
        elemInput.type = 'text';
        elemInput.classList.add('prompt-input');
        elemInput.addEventListener('keyup', function (event) {
            if (event.key == 'Enter')
                done.bind(_this)();
        });
        this.elemText.appendChild(br);
        this.elemText.appendChild(elemInput);
        this.clearActions();
        var ok = document.createElement('a');
        ok.innerText = '{.!OK.}';
        ok.href = 'javascript:';
        ok.classList.add('invert');
        ok.addEventListener('click', done.bind(this));
        this.elemActions.appendChild(ok);
        var cancel = document.createElement('a');
        cancel.innerText = '{.!Cancel.}';
        cancel.href = 'javascript:';
        cancel.classList.add('invert');
        cancel.addEventListener('click', function () {
            _this.close();
        });
        this.elemActions.appendChild(cancel);
        this.showDialog();
        elemInput.focus();
    };
    return Dialog;
}());
window.addEventListener('DOMContentLoaded', function () { return window.dialog = new Dialog(); });



[takeback-general.css|public|no log|cache]

/* <style> /**/
body {
    margin: 0;
    font-family: 'Takeback-Define-Font', 'Monda', sans-serif;
    background-color: black;
    font-size: 1.2em;
    color: white;
    text-align: center;
}
.animator-show { transform: inherit; }
.animator-hide { transform: scaleY(0); }

.background {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background: center / cover;
    background-image:
        radial-gradient(white, rgba(255,255,255,.2) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.15) 1px, transparent 30px),
        radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 40px),
        radial-gradient(white, rgba(255,255,255,.08) 3px, transparent 60px),
        radial-gradient(rgba(255,255,255,.4), rgba(255,255,255,.1) 2px, transparent 30px);
    background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
    background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
    z-index: -2;
}
.background-image {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background: center / cover;
    background-image: url('{.!_background_image.}');
    background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
    background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
    z-index: -2;
}
.background-mask {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: -1;
}
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
    color: white;
    background-color: transparent;
}
a:hover {
    color: #333333;
    background-color: white;
}
a:active {
    color: white;
    background-color: transparent;
    text-shadow: 0 0 4px white;
}
a {
    transition: all 0.3s;
    text-decoration: none;
}
a.invert:link, a.invert:visited {
    color: #333333;
    background-color: white;
}
a.invert:hover {
    color: white;
    background-color: transparent;
    border: 1px solid currentColor;
}
a.invert:active {
    color: white;
    background-color: transparent;
    text-shadow: 0 0 4px white;
}
a.invert {
    transition: all 0.3s;
    text-decoration: none;
    border: 1px solid transparent;
    padding: 0 0.1em;
}
hr, .linebottom {
    margin: 0;
    border-bottom: 1px solid white;
}
#dialog {
    position: fixed;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    transition: opacity 0.6s;
}
.dialog {
    position: fixed;
    width: 60%;
    left: 20%;
    top: 33%;
    border: 1px solid currentColor;
}
.dialog .prompt-input {
    width: 12em;
    font-size: 1.2em;
    height: 1em;
    border: 1px solid currentColor;
}
@media (max-width: 950px) {
    section#tooltip {
        bottom: unset;
        top: 1.8em;
    }
}
/* </style> */


[takeback-general.js|public|no log|cache]
{.comment| Here you can include other scripts for semantic scripting .}

{.$polyfills.js.}
{.$takeback-general-main.js.}


[takeback-index.css|public|no log|cache]
body {
    font-size: 1.2em;
}

header.index {
    width: 100%;
    border-bottom: 1px solid white;
    text-align: left;
}

header.index .logo {
    display: inline-block;
}

header.index nav a {
    display: inline-block;
    padding: 0.4em 0.5em;
}
main.index {
    width: 80%;
    margin: auto;
}
main.index h1 {
    font-weight: normal;
    font-size: 1.4em;
    margin: 1em 0;
}
.item {
    margin: 0 0 2em 0;
    padding: 0 0.5em;
}
.item a {
    font-size: 1.08em;
}
.item.left, .item.left .description, .item.left .border {
    text-align: left;
    margin-right: auto;
}
.item.right, .item.right .description, .item.right .border {
    text-align: right;
    margin-left: auto;
}
.item .description {
    font-size: 0.9em;
}
@keyframes swing {
    0% {
        left: 0em;
    }
    50% {
        left: 0.5em;
    }
    100% {
        left: 0em;
    }
}
.item a {
    font-size: 1.2em;
}
.item a .arrow {
    position: relative;
    transition: all 0.3s;
    animation: swing 1s ease-out 0s infinite;
}
.item a .arrow::after {
    content: '>>';
    font-style: italic;
}
.border {
    border-bottom: 1px solid white;
    width: 60%;
}
footer.index {
    font-size: small;
    color: gray;
    margin-top: 10em;
}
@media (max-width: 950px) {
    main.index {
        margin: 0;
        width: 100%;
    }
}


[takeback.index]

{.set|i|0.}
{.for each|data|{.!_index_data.}|{:
    {.switch|{.^i.}|,|
        0|{:{.set|IndexData.Title|{.^data.}.}:}|
        1|{:{.set|IndexData.Header0|{.^data.}.}:}|
        2|{:{.set|IndexData.Header1|{.^data.}.}:}|
        3|{:{.set|IndexData.Footer|{.^data.}.}:}|
        4|{:{.set|IndexData.Items|{.^data.}.}:}|
        5|{:{.set|IndexData.Indexes|{.^data.}.}:}|
    .}
    {.inc|i|1.}
:}.}

{.get-common-html|
	<link rel="stylesheet" href="/~takeback-index.css" />
	<title>{.fallback|{.^IndexData.Title.}|{.!HFS.}.}::{.!Home.}</title>
|
    <header class="index">
        <nav class="nav">
            <div class="logo">
                <a href="/" style="text-decoration: none;">
                    🌎<span>{.fallback|{.^IndexData.Header0.}|{.!HFS.}.}</span>
                </a>
            </div>
            {.for each|item|{.replace|\|{.no pipe||.}|{.^IndexData.Items.}.}|{:
                {.set|item.name|{.substring||;|{.^item.}|include=0.}.}
                {.set|item.link|{.substring|;||{.^item.}|include=0.}.}
                <a href="{.^item.link.}">{.^item.name.}</a>
            :}.}
        </nav>
    </header>
    <main class="index">
        <h1>{.fallback|{.^IndexData.Header1.}|{.!HTTP File Server.}.}</h1>
        <div id="itemlist">
            {.set|count|0.}
            {.for each|item|{.replace|\|{.no pipe||.}|{.^IndexData.Indexes.}.}|{:
                {.set|item.direction|{.if|{.=|{.mod|{.^count.}|2.}|0.}|left|right.}.}
                {.set|item.name|{.substring||[|{.^item.}|include=0.}.}
                {.set|item.link|{.substring|[|]|{.^item.}|include=0.}.}
                {.set|item.description|{.substring|]||{.^item.}|include=0.}.}
                <div class="item {.^item.direction.}">
                    <a href="{.^item.link.}">
                        {.^item.name.}
                        <span class="arrow"></span>
                    </a>
                    <div class="description">{.^item.description.}</div>
                    <div class="border"></div>
                </div>
                {.inc|count|1.}
            :}.}
        </div>
    </main>
    <footer class="index">{.^IndexData.Footer.}</footer>
    <script src="/~takeback-index.js"></script>
.}



[unauth]
{.if|%user%|{:
    {.get-common-html|
        <title>{.!No Access.}</title>
    |
        <h1>{.!No Access.}</h1>
        <p>{.!Your account have no access to this resource..}</p>
        <p><a class="invert" href="../">&lt;&lt; {.!Back.}</a></p>
    .}
:}|{:
    {.redirect|/~signin.}
:}.}


[unauthorized]
{.if|%user%|{:
    {.get-common-html|
        <title>{.!No Access.}</title>
    |
        <h1>{.!No Access.}</h1>
        <p>{.!Your account have no access to this resource..}</p>
        <p><a class="invert" href="../">&lt;&lt; {.!Back.}</a></p>
    .}
:}|{:
    {.redirect|/~signin.}
:}.}


[upload-failed]

<b class="failed">{.!FAILED.}</b>: %item-name% - %reason%<br />


[upload-results]

{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload Result.}</title>
    <style>
        body {
            text-align: left;
        }
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


[upload]

{.add header|Cache-Control: no-cache, max-age=0.}
{.get-common-html|
    <title>{.!Upload.}</title>
|
    <section class="linebottom" style="text-align: left;">
        <a href="./">⇦ {.!Back.}</a>
        {.if|{.can mkdir.}|
            <a id="newfolder" class="invert" style="float: right;" href="javascript:">📁 {.!New Folder.}</a>
        .}
    </section>
    <section>
        <p>{.!Upload to:.}%folder%</p>
        <p>{.!Free space left:.}%diskfree%B</p>
        <form id="uploadform" action="./" target="_parent" method="POST" enctype="multipart/form-data">
            <p data-upload="inputs"><input type="file" name="0" multiple /><br /></p>
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


