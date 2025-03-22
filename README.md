<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Roblox Group Games Viewer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: white;
            text-align: center;
            padding-top: 50px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        input {
            padding: 10px;
            width: 300px;
            margin-bottom: 20px;
            border: none;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            background-color: #ff7f50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .game-card {
            border: 1px solid #ff7f50;
            padding: 10px;
            margin: 10px;
            border-radius: 8px;
            background-color: #1e1e1e;
        }
        a {
            color: #ff7f50;
            text-decoration: none;
        }
        footer {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Roblox Group Games Viewer</h1>
        <input id="groupIdInput" type="text" placeholder="Enter Group ID" />
        <button onclick="fetchGames()">Show Group Games</button>
        <div id="gamesContainer"></div>
        <footer>
            Created with ❤️ by Lake
        </footer>
    </div>

    <script>
        async function fetchGames() {
            const groupId = document.getElementById('groupIdInput').value.trim();
            if (!groupId) {
                alert("Please enter a valid Group ID.");
                return;
            }

            const apiUrl = `https://games.roblox.com/v2/groups/${groupId}/gamesV2?accessFilter=1&limit=100&sortOrder=Asc`;

            try {
                const response = await fetch(apiUrl);
                if (!response.ok) throw new Error("Failed to fetch games.");

                const data = await response.json();
                displayGames(data.data);
            } catch (error) {
                document.getElementById('gamesContainer').innerHTML = `<p>Error: ${error.message}</p>`;
            }
        }

        function displayGames(games) {
            const container = document.getElementById('gamesContainer');
            container.innerHTML = "";

            if (games.length === 0) {
                container.innerHTML = "<p>No games found for this group.</p>";
                return;
            }

            games.forEach(game => {
                const gameCard = document.createElement('div');
                gameCard.className = 'game-card';
                gameCard.innerHTML = `
                    <h2>${game.name}</h2>
                    <p>Players: ${game.playing}</p>
                    <a href="https://www.roblox.com/games/${game.rootPlaceId}" target="_blank">Play Game</a>
                `;
                container.appendChild(gameCard);
            });
        }
    </script>
</body>
</html>
