<?php
require('credentials.php');

// Connexion à la base de données
try {
    $pdo = new PDO(
            "mysql:host=$host;dbname=$dbname;charset=$charset",
            $user,
            $password,
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}

// Récupération de tous les matériels avec leurs parents
$sql = "
    SELECT 
        m.id_materiel AS id,
        m.nom,
        m.annee,
        m.details,
        t.libelle AS type,
        p.nom AS parent_nom
    FROM materiel m
    INNER JOIN type_materiel t ON m.id_type = t.id_type
    LEFT JOIN materiel p ON m.id_parent = p.id_materiel
    ORDER BY m.id_materiel ASC
";

$stmt = $pdo->query($sql);
$materiels = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inventaire Matériel Informatique</title>
    <style>
        body { font-family: sans-serif; padding: 20px; background: #f4f4f4; }
        table { border-collapse: collapse; width: 100%; background: #fff; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #667eea; color: white; }
        .empty { color: #aaa; text-align: center; }
    </style>
</head>
<body>
<h1>Inventaire du matériel</h1>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Année</th>
        <th>Détails</th>
        <th>Type</th>
        <th>Appartient à</th>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($materiels as $m): ?>
        <tr>
            <td><?php echo htmlspecialchars($m['id']); ?></td>
            <td><?php echo htmlspecialchars($m['nom']); ?></td>
            <td><?php echo htmlspecialchars($m['annee']); ?></td>
            <td><?php echo $m['details'] ? htmlspecialchars($m['details']) : '<span class="empty">—</span>'; ?></td>
            <td><?php echo htmlspecialchars($m['type']); ?></td>
            <td><?php echo $m['parent_nom'] ? htmlspecialchars($m['parent_nom']) : '<span class="empty">—</span>'; ?></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</body>
</html>
