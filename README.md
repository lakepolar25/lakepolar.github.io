<!DOCTYPE html>
<html lang="en">
<head>
    <title>BIG Games DevProduct Scanner</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .product-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .product {
            border: 2px solid black;
            padding: 10px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <h1>BIG Games DevProduct Scanner</h1>
    <button onclick="fetchDevProducts(3317771874)">Show Products for 3317771874</button>
    <button onclick="fetchDevProducts(6401952734)">Show Products for 6401952734</button>

    <div id="product-list" class="product-container"></div>

    <script>
        async function fetchDevProducts(universeId) {
            const productList = document.getElementById('product-list');
            productList.innerHTML = '<p>Loading...</p>';

            try {
                const response = await fetch(`https://apis.roblox.com/developer-products/v1/universes/${universeId}/products`);
                if (!response.ok) throw new Error(`Error ${response.status}: Failed to fetch data.`);

                const data = await response.json();
                productList.innerHTML = '';

                if (data.length === 0) {
                    productList.innerHTML = '<p>No developer products found.</p>';
                    return;
                }

                data.forEach(product => {
                    const productDiv = document.createElement('div');
                    productDiv.className = 'product';
                    productDiv.innerHTML = `<strong>${product.Name}</strong><br>ID: ${product.ProductId}`;
                    productList.appendChild(productDiv);
                });

            } catch (error) {
                productList.innerHTML = `<p>Error: ${error.message}</p>`;
            }
        }
    </script>
</body>
</html>
