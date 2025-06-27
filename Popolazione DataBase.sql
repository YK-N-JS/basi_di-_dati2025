--Popolazione User:

insert into "user" (username, "Password") values
('Davide', 'Davide'),
('Giulia', 'Giulia'),
('Silvio', 'Silvio'),
('Porfirio', 'Porfirio');


--Popolazione bacheca: non è stato ritenuto necessario inserire a mano delle bacheche, in quanto già inserite dalla
--funzione "createDefaultBachecheFunction" dopo l'inserimento di un utente


--Popolazione ToDo:
--Per i ToDo è stato ritenuto superfluo inserire valori per i campi "icon" e "color", in quanto non hanno un vero utilizzo
--al di fuori dell'interfaccia grafica

insert into todo (title, url, description, "Owner", complete_bydate, completed)
values
('Studiare', 'https://youtu.be/dQw4w9WgXcQ?si=jf-cwJ4iZyXNxaN', 'Studiare le ~cose~', 'Davide', '2025-6-23', true),
('Completare il pokédex', 'https://www.pokemon.com/it/pokedex', 'Trovare Shaymin e Manaphy', 'Giulia', '2026-1-31', false),
('Riposare', 'https://open.spotify.com/playlist/37i9dQZF1DXbITWG1ZJKYt?si=rHt_8ebFSza7e1UT__J4cQ', 'Ascolta i grandi classici del Jazz per riposarti', 'Porfirio', '2025-6-30', false),
('Correggere le prove intercorso', 'http://localhost:8080/', 'Correggere la seconda prova intercorso di Basi di dati I', 'Silvio', '2025-6-23', true);
('Mangiare', 'http://mangiaresano.wolrd/', 'Mangiare sempre tanta frutta e verdura', 'Porfirio', '3000-01-01', false)


--Popolazione Placement:

insert into placement (idbacheca, idtodo)
values
(2, 1),(5, 1),
(8, 2), (1, 2),
(16, 3), (9, 3),
(11, 4), (13, 4),
(13, 5),(1, 5),(5, 5),(9, 5);