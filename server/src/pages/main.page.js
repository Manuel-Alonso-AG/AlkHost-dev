const mainHtml = `
        <html>
            <head>
                <title>AlkHost -dev</title>
				<style>
					*{
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
						color: #3365afff;
					}
					p {
						margin: 10px 0;
					}
					main {
						width:800px;
						background-color: #fff;
						border-radius: 10px;
						padding: 30px;
					}
					section {
						background-color: #f4f4f4;
						border-radius: 10px;
						padding: 20px;
					}
					ul{
						padding: 10px 0px 10px 50px;
					}
					li {
						margin: 10px 0;
					}
				</style>
            </head>
            <body>
				<main>
					<h1>AlkHost dev</h1>
					<br/>
					
					<p>Entorno de desarrollo local web</p>
					<p>Esta en desarrollo</p>
					
					<br/>

					<section>
						<ul>
							<li><a href="projects/">Listado de projectos</a></li>
						</ul>
					</section>

					<br/>

					<h3>By -Alons</h3>
				</main>
            </body>
        </html>
`;

export default mainHtml;