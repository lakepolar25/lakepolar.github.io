<!DOCTYPE html>
<html lang="en">
<head>
  <title>Roblox Group Game Viewer</title>
  <style>
    body {
      background: #121212;
      color: white;
      font-family: Arial, sans-serif;
      text-align: center;
      padding: 20px;
    }
    input {
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 10px;
    }
    button {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      background: purple;
      color: white;
      cursor: pointer;
      margin: 5px;
    }
    .game-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      margin-top: 20px;
    }
    .game-card {
      background: #1e1e1e;
      border-radius: 10px;
      padding: 10px;
      width: 200px;
    }
    img {
      border-radius: 10px;
      width: 150px;
      height: 150px;
    }
    .footer {
      margin-top: 40px;
      opacity: 0.8;
    }
  </style>
</head>
<body>
  <h1>Roblox Group Game Viewer</h1>
  <input id="groupId" type="number" placeholder="Enter Group ID" />
  <button onclick="fetchGames()">Fetch Games</button>

  <div id="gameContainer" class="game-container"></div>

  <div class="footer">
    <p>This site is not made or affiliated with Roblox Corporation. It is for viewing Roblox group games.</p>
    <button onclick="window.open('https://discord.com', '_blank')">🎮 Discord</button>
    <button onclick="window.open('https://twitter.com', '_blank')">🦜 Twitter</button>
  </div>

  <script>
    async function fetchGames() {
      const groupId = document.getElementById('groupId').value;
      if (!groupId) return alert('Please enter a valid Group ID.');

      const gameContainer = document.getElementById('gameContainer');
      gameContainer.innerHTML = 'Loading games...';

      try {
        const response = await fetch(`https://your-cloudflare-worker-url.workers.dev/?groupId=${groupId}`);
        const data = await response.json();

        if (!data || !data.data || data.data.length === 0) {
          gameContainer.innerHTML = 'No games found for this group.';
          return;
        }

        gameContainer.innerHTML = '';
        for (const game of data.data) {
          const iconResponse = await fetch(`https://thumbnails.roblox.com/v1/places/gameicons?placeIds=${game.rootPlaceId}&size=150x150&format=png`);
          const iconData = await iconResponse.json();
          const iconUrl = iconData.data?.[0]?.imageUrl || 'https://via.placeholder.com/150';

          gameContainer.innerHTML += `
            <div class="game-card">
              <img src="${iconUrl}" alt="Game Icon">
              <h3>${game.name}</h3>
              <p>Players: ${game.playing || 0}</p>
              <p>${game.description || 'No description available.'}</p>
              <button onclick="window.open('https://www.roblox.com/games/${game.rootPlaceId}', '_blank')">Play Game</button>
            </div>`;
        }
      } catch (error) {
        console.error('Error fetching games:', error);
        gameContainer.innerHTML = 'Error fetching games. Try again later.';
      }
    }
  </script>
</body>
</html>
