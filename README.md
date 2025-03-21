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

    <button onclick="fetchProducts(3317771874, 'Pet Simulator 99')">Show Developer Products for Pet Simulator 99</button>
    <button onclick="fetchProducts(6401952734, 'PETS GO')">Show Developer Products for PETS GO</button>

    <div id="output">Select a game to view its developer products.</div>

    <script>
        const proxyUrl = "https://your-worker-id.workers.dev";

        async function fetchProducts(universeId, gameName) {
            const output = document.getElementById('output');
            output.textContent = 'Loading developer products...';

            try {
                const response = await fetch(`${proxyUrl}?universeId=${universeId}`);
                if (!response.ok) throw new Error(`Error ${response.status}: Failed to fetch data`);

                const data = await response.json();

                if (!Array.isArray(data) || data.length === 0) {
                    output.textContent = `No developer products found for ${gameName}.`;
                    return;
                }

                output.innerHTML = `<h2>Developer Products for ${gameName}</h2>`;
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
