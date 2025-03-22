<!DOCTYPE html>
<html lang="en">
<head>
    <title>BIG Games DevProduct Scanner</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1a1a2e;
            color: white;
            text-align: center;
            margin: 20px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            background: #2b2b4b;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding: 20px;
            max-width: 300px;
            text-align: left;
            transition: transform 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .asset-image {
            width: 100px;
            height: 100px;
            border-radius: 8px;
        }
        .expand {
            margin-top: 10px;
            padding: 8px 16px;
            background: #4b4b8a;
            border: none;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>BIG Games DevProduct Scanner</h1>
    <button onclick="fetchProducts(3317771874)">Pet Simulator 99</button>
    <button onclick="fetchProducts(6401952734)">PETS GO</button>

    <div class="container" id="output">Select a game to view its developer products.</div>

    <script>
        async function fetchProducts(universeId) {
            const output = document.getElementById('output');
            output.innerHTML = 'Loading developer products...';

            try {
                const proxyUrl = `https://mskswokcev.devrahsanko.workers.dev?universeId=${universeId}`;
                const response = await fetch(proxyUrl);
                if (!response.ok) throw new Error(`Error ${response.status}: Failed to fetch data`);

                const data = await response.json();

                if (!data || data.length === 0) {
                    output.innerHTML = 'No developer products found.';
                    return;
                }

                output.innerHTML = '';
                data.forEach(product => {
                    output.innerHTML += `
                        <div class="card">
                            <img class="asset-image" src="https://www.roblox.com/asset-thumbnail/image?assetId=${product.iconImageAssetId || 0}&width=150&height=150" alt="Asset Image">
                            <h2>${product.name}</h2>
                            <p><strong>Price:</strong> ${product.priceInRobux} Robux</p>
                            <p><strong>Created:</strong> ${new Date(product.created).toDateString()}</p>
                            <p><strong>By:</strong> Unknown Creator</p>
                            <button class="expand" onclick="alert('Product ID: ${product.id}')">Expand</button>
                        </div>
                    `;
                });

            } catch (error) {
                output.innerHTML = `Error: ${error.message}`;
            }
        }
    </script>
</body>
</html>
