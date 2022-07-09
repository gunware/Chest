-- phpMyAdmin SQL Dump
-- version 4.6.6deb4+deb9u2
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Sam 09 Juillet 2022 à 09:26
-- Version du serveur :  10.1.48-MariaDB-0+deb9u2
-- Version de PHP :  7.0.33-0+deb9u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `fxserver`
--

-- --------------------------------------------------------

--
-- Structure de la table `Aft_Coffre_item`
--

CREATE TABLE `Aft_Coffre_item` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `label` text NOT NULL,
  `qty` int(11) NOT NULL,
  `chestid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `Aft_Coffre_item`
--

INSERT INTO `Aft_Coffre_item` (`id`, `name`, `label`, `qty`, `chestid`) VALUES
(6, 'coffre2', 'Coffre moyen', 1, 3),
(13, 'biere', 'Bière blonde', 20, 1),
(14, 'water', 'Bouteille d\'eau', 1, 1),
(18, 'godex', 'Boule de geisha', 0, 21),
(21, 'biere', 'Bière blonde', 25, 21),
(22, 'bieremiel', 'Bière au miel', 25, 21),
(23, 'bierecerise', 'Bière cerise', 25, 21),
(24, 'bierecitron', 'Bière citron', 25, 21),
(25, 'biereblanche', 'Bière blanche', 25, 21),
(26, 'bierebrune', 'Bière brune', 25, 21),
(27, 'bierejingembre', 'Bière gingembre', 25, 21),
(28, 'bierelait', 'Liqueur au lait de chèvre à la mure', 25, 21),
(29, 'liqueurpomme', 'Liqueur chèvre à la pomme', 25, 21),
(30, 'liqueurchataigne', 'Liqueur de chèvre à la châtaigne', 25, 21),
(31, 'liqueurbanane', 'Liqueur de chèvre à la banane', 25, 21),
(32, 'liqueurmangue', 'Liqueur de chèvre à la mangue', 20, 21),
(33, 'distil', 'Bière distillée', 8, 21),
(34, 'ce', 'Cigarette électronique', 1, 22),
(35, 'gode', 'Gode', 1, 22),
(36, 'gode', 'Gode', 2, 23),
(37, 'gode8', 'Gode simple', 1, 23),
(38, 'gode3', 'Gode vibrant', 1, 23),
(40, 'godex', 'Boule de geisha', 1, 23),
(41, 'gode6', 'Plug anal', 1, 23),
(42, 'gode4', 'Sextoys', 1, 23),
(43, 'btempax', 'Boîte de tampon', 11, 23),
(44, 'packetseriviette', 'Paquet de serviette hygiénique', 9, 23),
(45, 'gode5', 'Vibromasseur', 1, 23),
(46, 'gode9', 'Vibromasseur très puissant', 1, 23),
(47, 'gode7', 'Virbomasseur puissant', 1, 23),
(48, 'tetecherhe', 'Gode à tête chercheuse', 1, 23),
(49, 'tampon', 'Tampon hygiénique', 8, 23);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Aft_Coffre_item`
--
ALTER TABLE `Aft_Coffre_item`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Aft_Coffre_item`
--
ALTER TABLE `Aft_Coffre_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
