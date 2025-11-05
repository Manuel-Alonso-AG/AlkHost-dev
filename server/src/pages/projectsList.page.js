const HEAD = `
		<html>
            <head>
                <title>AlkHost -dev</title>
				<style>
					* {
						box-sizing: border-box;
						margin: 0px;
						padding: 0px;
					}
					body {
						font-family: Arial, sans-serif;
						background-color: #f4f4f4;
						color: #333;
						padding: 20px;
						display: flex;
						justify-content: center;
					}
					h1 {
						color: #192025ff;
						margin: 10px;
					}
					ul{
						padding: 10px 0px 10px 50px;
					}
					li {
						margin: 10px 0;
					}
					div {
						width:800px;
						background-color: #fff;
						border-radius: 10px;
						padding: 10px;
					}
				</style>
            </head>
            <body>
				<div>
                	<h1>: Listado de projectos</h1>
					<ul>
                `;

let html = HEAD;

function reloadHtml() {
	html = HEAD;
}

function addProject(projectName) {
    const dirFile = `http://localhost:3000/projects/${projectName}/`;
	html += `<li><a href = "${dirFile}">${dirFile}</a></li>`;

}

function projectListPage() {
    html += `</ul></div></body></html>`
    return html;
}

export default {
    addProject,
    projectListPage,
	reloadHtml
}