<!DOCTYPE html>
<html lang="en">
<head>
    <title>BIG Games DevProduct Scanner</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
        }
        button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        #output {
            margin-top: 20px;
            white-space: pre-wrap;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>BIG Games DevProduct Scanner</h1>

    <button onclick="fetchProducts(3317771874)">Show Developer Products for Pet Simulator 99</button>
    <button onclick="fetchProducts(6401952734)">Show Developer Products for PETS GO</button>

    <div id="output">Select a game to view its developer products.</div>

    <script>
        async function fetchProducts(universeId) {
            const output = document.getElementById('output');
            output.textContent = 'Loading developer products...';

            try {
                const response = await fetch(`https://apis.roblox.com/developer-products/v1/universes/${universeId}/developerproducts?pageNumber=1&pageSize=1000`);
                if (!response.ok) {
                    throw new Error(`Error ${response.status}: Failed to fetch data`);
                }

                const data = await response.json();

                if (data.length === 0) {
                    output.textContent = 'No developer products found.';
                    return;
                }

                output.innerHTML = `<h2>Developer Products for Universe ${universeId}</h2>`;
                data.forEach(product => {
                    output.innerHTML += `
                        <p>
                            <strong>Name:</strong> ${product.name}<br>
                            <strong>Price:</strong> ${product.priceInRobux} Robux<br>
                            <strong>ID:</strong> ${product.id}
                        </p>
                        <hr>
                    `;
                });

            } catch (error) {
                output.textContent = `Error: ${error.message}`;
            }
        }
    </script>
</body>
</html>
