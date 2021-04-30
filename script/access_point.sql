-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-04-2021 a las 17:27:10
-- Versión del servidor: 8.0.23-0ubuntu0.20.04.1
-- Versión de PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `access_point`
--
CREATE DATABASE IF NOT EXISTS `access_point` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `access_point`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_dispositivo_rfid`
--

DROP TABLE IF EXISTS `cat_dispositivo_rfid`;
CREATE TABLE `cat_dispositivo_rfid` (
  `cat_dispositivo_rfid_id` int NOT NULL,
  `cat_local_id` int DEFAULT NULL,
  `cat_inmueble_id` int NOT NULL,
  `numero_serie` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_evento_tarjeta`
--

DROP TABLE IF EXISTS `cat_evento_tarjeta`;
CREATE TABLE `cat_evento_tarjeta` (
  `cat_evento_tarjeta_id` int NOT NULL,
  `nombre_evento` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cat_evento_tarjeta`
--

INSERT INTO `cat_evento_tarjeta` (`cat_evento_tarjeta_id`, `nombre_evento`) VALUES
(1, 'Entrada'),
(2, 'Salida'),
(3, 'Registro'),
(4, 'Desactivada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_inmueble`
--

DROP TABLE IF EXISTS `cat_inmueble`;
CREATE TABLE `cat_inmueble` (
  `id` int NOT NULL,
  `description` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_local`
--

DROP TABLE IF EXISTS `cat_local`;
CREATE TABLE `cat_local` (
  `cat_local_id` int NOT NULL,
  `numero_local` varchar(32) NOT NULL,
  `nombre_local` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_locatario`
--

DROP TABLE IF EXISTS `cat_locatario`;
CREATE TABLE `cat_locatario` (
  `cat_locatario_id` int NOT NULL,
  `cat_local_id` int NOT NULL,
  `cat_puesto_id` int NOT NULL,
  `nombre_locatario` varchar(64) NOT NULL,
  `apellidos_locatario` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_puesto`
--

DROP TABLE IF EXISTS `cat_puesto`;
CREATE TABLE `cat_puesto` (
  `cat_puesto_id` int NOT NULL,
  `nombre_puesto` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cat_puesto`
--

INSERT INTO `cat_puesto` (`cat_puesto_id`, `nombre_puesto`) VALUES
(1, 'Administrador'),
(2, 'Empleado'),
(3, 'Seguridad'),
(4, 'Mantenimiento'),
(5, 'Intendente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_tarjeta`
--

DROP TABLE IF EXISTS `cat_tarjeta`;
CREATE TABLE `cat_tarjeta` (
  `cat_tarjeta_id` int NOT NULL,
  `cat_locatario_id` int NOT NULL,
  `numero_tarjeta` varchar(32) NOT NULL,
  `codigo_tarjeta` varchar(16) NOT NULL,
  `estado_tarjeta` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resource`
--

DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` int NOT NULL,
  `rule_id` int NOT NULL,
  `description` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rule`
--

DROP TABLE IF EXISTS `rule`;
CREATE TABLE `rule` (
  `id` int NOT NULL,
  `description` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rule`
--

INSERT INTO `rule` (`id`, `description`, `status`) VALUES
(1, 'superuser', 1),
(2, 'admin', 1),
(3, 'manager', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_log_tarjeta`
--

DROP TABLE IF EXISTS `tbl_log_tarjeta`;
CREATE TABLE `tbl_log_tarjeta` (
  `tbl_log_rfid_id` int NOT NULL,
  `cat_dispositivo_rfid_id` int NOT NULL,
  `cat_tarjeta_id` int NOT NULL,
  `cat_evento_tarjeta_id` int NOT NULL,
  `fecha_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `user` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL,
  `rule_id` tinyint(1) NOT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `user`, `password`, `rule_id`, `mail`, `status`) VALUES
(1, 'Aztek', 'Control', 'aztek', '5fc57ee87e38656477e433ce9ca368e5', 1, 'ecarrera@aztektec.com.mx', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cat_dispositivo_rfid`
--
ALTER TABLE `cat_dispositivo_rfid`
  ADD PRIMARY KEY (`cat_dispositivo_rfid_id`),
  ADD UNIQUE KEY `numerodeserie` (`numero_serie`),
  ADD KEY `fk2_cat_local_id` (`cat_local_id`),
  ADD KEY `cat_inmueble_id` (`cat_inmueble_id`);

--
-- Indices de la tabla `cat_evento_tarjeta`
--
ALTER TABLE `cat_evento_tarjeta`
  ADD PRIMARY KEY (`cat_evento_tarjeta_id`);

--
-- Indices de la tabla `cat_inmueble`
--
ALTER TABLE `cat_inmueble`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_local`
--
ALTER TABLE `cat_local`
  ADD PRIMARY KEY (`cat_local_id`);

--
-- Indices de la tabla `cat_locatario`
--
ALTER TABLE `cat_locatario`
  ADD PRIMARY KEY (`cat_locatario_id`),
  ADD KEY `fk_cat_local_id` (`cat_local_id`),
  ADD KEY `fk_cat_puesto_id` (`cat_puesto_id`);

--
-- Indices de la tabla `cat_puesto`
--
ALTER TABLE `cat_puesto`
  ADD PRIMARY KEY (`cat_puesto_id`);

--
-- Indices de la tabla `cat_tarjeta`
--
ALTER TABLE `cat_tarjeta`
  ADD PRIMARY KEY (`cat_tarjeta_id`),
  ADD KEY `fk_cat_locatario_id` (`cat_locatario_id`);

--
-- Indices de la tabla `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rule_id` (`rule_id`);

--
-- Indices de la tabla `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_log_tarjeta`
--
ALTER TABLE `tbl_log_tarjeta`
  ADD PRIMARY KEY (`tbl_log_rfid_id`),
  ADD KEY `fk_cat_tarjeta_id` (`cat_tarjeta_id`),
  ADD KEY `cat_evento_tarjeta_id` (`cat_evento_tarjeta_id`),
  ADD KEY `fk_cat_dispositivo_id` (`cat_dispositivo_rfid_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rule_id` (`rule_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cat_dispositivo_rfid`
--
ALTER TABLE `cat_dispositivo_rfid`
  MODIFY `cat_dispositivo_rfid_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_evento_tarjeta`
--
ALTER TABLE `cat_evento_tarjeta`
  MODIFY `cat_evento_tarjeta_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cat_inmueble`
--
ALTER TABLE `cat_inmueble`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_local`
--
ALTER TABLE `cat_local`
  MODIFY `cat_local_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_locatario`
--
ALTER TABLE `cat_locatario`
  MODIFY `cat_locatario_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_puesto`
--
ALTER TABLE `cat_puesto`
  MODIFY `cat_puesto_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cat_tarjeta`
--
ALTER TABLE `cat_tarjeta`
  MODIFY `cat_tarjeta_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rule`
--
ALTER TABLE `rule`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_log_tarjeta`
--
ALTER TABLE `tbl_log_tarjeta`
  MODIFY `tbl_log_rfid_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cat_dispositivo_rfid`
--
ALTER TABLE `cat_dispositivo_rfid`
  ADD CONSTRAINT `fk2_cat_inmueble_id` FOREIGN KEY (`cat_inmueble_id`) REFERENCES `cat_inmueble` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk2_cat_local_id` FOREIGN KEY (`cat_local_id`) REFERENCES `cat_local` (`cat_local_id`);

--
-- Filtros para la tabla `cat_locatario`
--
ALTER TABLE `cat_locatario`
  ADD CONSTRAINT `fk_cat_local_id` FOREIGN KEY (`cat_local_id`) REFERENCES `cat_local` (`cat_local_id`),
  ADD CONSTRAINT `fk_cat_puesto_id` FOREIGN KEY (`cat_puesto_id`) REFERENCES `cat_puesto` (`cat_puesto_id`);

--
-- Filtros para la tabla `cat_tarjeta`
--
ALTER TABLE `cat_tarjeta`
  ADD CONSTRAINT `fk_cat_locatario_id` FOREIGN KEY (`cat_locatario_id`) REFERENCES `cat_locatario` (`cat_locatario_id`);

--
-- Filtros para la tabla `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `fk_resource_role` FOREIGN KEY (`rule_id`) REFERENCES `rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `tbl_log_tarjeta`
--
ALTER TABLE `tbl_log_tarjeta`
  ADD CONSTRAINT `fk_cat_dispositivo_id` FOREIGN KEY (`cat_dispositivo_rfid_id`) REFERENCES `cat_dispositivo_rfid` (`cat_dispositivo_rfid_id`),
  ADD CONSTRAINT `fk_cat_evento_tarjeta_id` FOREIGN KEY (`cat_evento_tarjeta_id`) REFERENCES `cat_evento_tarjeta` (`cat_evento_tarjeta_id`),
  ADD CONSTRAINT `fk_cat_tarjeta_id` FOREIGN KEY (`cat_tarjeta_id`) REFERENCES `cat_tarjeta` (`cat_tarjeta_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
