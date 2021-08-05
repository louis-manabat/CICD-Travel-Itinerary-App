<?php
require_once 'tools.php';

if (!isset($_POST['submit'])) {
    redirect('main.php');
}

$index = intval($_POST['index']);
$user = query_login_table($_SESSION['current_email']);
$itinerary = $user['Item']['itineraries']['L'][$index]['L'];
?><!DOCTYPE html>
<html lang="en">

<head>
    <title>Saved itineraries</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/styles.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <div class="container-fluid" id="main-title">
        <div class="col-lg-3"></div>
        <div class="col-lg-6 text-center">
            <img src="<?= $s3_base_url . 'logo.png' ?>" height="85px">
        </div>
        <div class="col-lg-3"></div>
    </div>

    <div class="row section container-fluid" id="navigation-bar">
        <div class="col-lg-1"></div>
        <div class="col-lg-7">
            <nav class="collapse navbar-collapse">
                <div class="navbar-nav">
                    <ul class="nav navbar-nav mr-auto justify-content-end">
                        <li class="nav-item">
                            <a href='new_itinerary.php' id="nav-links">New itinerary</a>
                        </li>
                        <li class="nav-item">
                            <a href='user.php' id="nav-links">Past itineraries</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="col-lg-4">
            <nav class="collapse navbar-collapse">
                <div class="navbar-nav">
                    <ul class="nav navbar-nav mr-auto justify-content-end">
                        <li class="nav-item">
                            <p id="nav-links">Welcome, <?= $_SESSION['current_user'] ?>! (<a href='logout.php' id="logout">logout</a>)</p>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <div class="row section container-fluid" id="main-body">
        <div class="col-lg-3"></div>
        <div class="col-lg-6">
            <h2 id="page-title">Saved Itinerary</h2>
            <hr>
            <div class="container-fluid">
                <p><strong>Origin</strong></p>
                <p><?= $itinerary[0]['M']['city']['S'] . ', ' . $itinerary[0]['M']['country']['S'] ?></p>
                <p><strong>Depart on </strong><?= (new DateTime($itinerary[0]['M']['date']['S']))->format('jS F Y') ?></p>
                <hr>
            </div>

            <?php
            foreach ($itinerary as $index => $location) {
                if ($index > 0) {
                    $combinedname = $itinerary[$index]['M']['city']['S'] . ', ' . $itinerary[$index]['M']['country']['S'];
                    $arrdate = (new DateTime($itinerary[$index - 1]['M']['date']['S']))->format('jS F Y');
                    $depdate = (new DateTime($itinerary[$index]['M']['date']['S']))->format('jS F Y');
                    echo '<div class="container-fluid">
                        <p><strong>Destination ' . $index . '</strong></p>
                        <p>' . $combinedname . '</p>
                        <p><strong>Arrive on </strong>' . $arrdate . '</p>
                        <p><strong>Depart on </strong>' . $depdate . '</p>
                    </div>
                    <hr/>';
                }
            }
            ?>
          
            <div class="container-fluid">
                <p><strong>Return Destination</strong></p>
                <p><?= $itinerary[0]['M']['city']['S'] . ', ' . $itinerary[0]['M']['country']['S'] ?></p>
                <p><strong>Arrive on </strong><?= (new DateTime($itinerary[count($itinerary) - 1]['M']['date']['S']))->format('jS F Y') ?></p>
                <hr>
            </div>

            <form action="user.php" method="POST"><input class="form-control" type="submit" name="submit" value="Back"></form>
            <form action="email.php" method="POST"><input type='hidden' name='index' value='<?= intval($_POST['index']) ?>'><input class="form-control" type="submit" name="submit" value="Email to me"></form>
        </div>
        <div class="col-lg-3"></div>
    </div>
    <br/><br/><br/><br/><br/><br/>
</body>

<footer class="container-fluid" id="footer">
    <div>
        <p>COSC2626 Cloud Computing - Assessment 3</p>
        <p><span>&#169;</span>James Dimos (s3722398)<br>
            <span>&#169;</span>Louis Manabat (s3719633)
        </p>
    </div>
</footer>

</html>
