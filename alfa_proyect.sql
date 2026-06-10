-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-05-2026 a las 04:43:59
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alfa_proyect`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado_cita` enum('PENDIENTE','CONFIRMADA','CANCELADA','FINALIZADA') DEFAULT 'PENDIENTE',
  `id_usuario` int(11) NOT NULL,
  `id_moto` int(11) NOT NULL,
  `id_taller` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `fecha`, `hora`, `estado_cita`, `id_usuario`, `id_moto`, `id_taller`, `id_servicio`) VALUES
(1, '2026-06-10', '08:00:00', 'CONFIRMADA', 1, 1, 1, 1),
(2, '2026-06-11', '10:30:00', 'PENDIENTE', 2, 3, 2, 3),
(3, '2026-06-12', '02:00:00', 'CONFIRMADA', 3, 4, 3, 4),
(4, '2026-06-13', '09:15:00', 'FINALIZADA', 4, 5, 4, 5),
(5, '2026-06-14', '11:00:00', 'CANCELADA', 1, 2, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `id_cotizacion` int(11) NOT NULL,
  `fecha_cotizacion` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado_cotizacion` enum('PENDIENTE','APROBADA','RECHAZADA') DEFAULT 'PENDIENTE',
  `id_orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`id_cotizacion`, `fecha_cotizacion`, `total`, `estado_cotizacion`, `id_orden`) VALUES
(1, '2026-06-10', 80000.00, 'APROBADA', 1),
(2, '2026-06-11', 120000.00, 'PENDIENTE', 2),
(3, '2026-06-12', 95000.00, 'APROBADA', 3),
(4, '2026-06-13', 180000.00, 'APROBADA', 4),
(5, '2026-06-14', 70000.00, 'RECHAZADA', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moto`
--

CREATE TABLE `moto` (
  `id_moto` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `cilindraje` int(11) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `kilometraje` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `moto`
--

INSERT INTO `moto` (`id_moto`, `placa`, `marca`, `modelo`, `cilindraje`, `color`, `year`, `kilometraje`, `id_usuario`) VALUES
(1, 'FGV12A', 'BAJAJ', 'NS200', 200, 'Negro', 2022, 18000, 1),
(2, 'DFD45B', 'YAMAHA', 'MT03', 321, 'Azul', 2023, 9500, 1),
(3, 'HJU78C', 'HONDA', 'CB125F', 125, 'Rojo', 2021, 25000, 2),
(4, 'GTS32D', 'AKT', 'NKD125', 125, 'Blanco', 2020, 31000, 3),
(5, 'MOE65E', 'SUZUKI', 'Gixxer 150', 150, 'Gris', 2024, 4000, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_trabajo`
--

CREATE TABLE `orden_trabajo` (
  `id_orden` int(11) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `descripcion_falla` text DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `estado_orden` enum('ABIERTA','EN_PROCESO','FINALIZADA') DEFAULT 'ABIERTA',
  `id_cita` int(11) NOT NULL,
  `id_tecnico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_trabajo`
--

INSERT INTO `orden_trabajo` (`id_orden`, `fecha_ingreso`, `descripcion_falla`, `diagnostico`, `estado_orden`, `id_cita`, `id_tecnico`) VALUES
(1, '2026-06-10', 'Ruido extraño en el motor', 'Cambio de aceite y ajuste de piezas', 'EN_PROCESO', 1, 1),
(2, '2026-06-11', 'Fallas en luces delanteras', 'Problema en el sistema eléctrico', 'ABIERTA', 2, 3),
(3, '2026-06-12', 'Desgaste en frenos', 'Cambio de pastillas y ajuste', 'FINALIZADA', 3, 4),
(4, '2026-06-13', 'Cadena desgastada', 'Reemplazo de kit de arrastre', 'FINALIZADA', 4, 5),
(5, '2026-06-14', 'Vibración en suspensión', 'Revisión pendiente', 'ABIERTA', 5, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('EFECTIVO','TARJETA','TRANSFERENCIA','NEQUI','DAVIPLATA') DEFAULT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado_pago` enum('PENDIENTE','PAGADO','RECHAZADO') DEFAULT 'PENDIENTE',
  `id_cotizacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `monto`, `metodo_pago`, `fecha_pago`, `estado_pago`, `id_cotizacion`) VALUES
(1, 80000.00, 'NEQUI', '2026-06-10 14:30:00', 'PAGADO', 1),
(2, 120000.00, 'TRANSFERENCIA', '2026-06-11 16:00:00', 'PENDIENTE', 2),
(3, 95000.00, 'EFECTIVO', '2026-06-12 08:15:00', 'PAGADO', 3),
(4, 180000.00, 'TARJETA', '2026-06-13 15:45:00', 'PAGADO', 4),
(5, 70000.00, 'DAVIPLATA', '2026-06-14 17:20:00', 'RECHAZADO', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `duracion_estimada` varchar(50) DEFAULT NULL,
  `id_taller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`id_servicio`, `nombre_servicio`, `descripcion`, `costo`, `duracion_estimada`, `id_taller`) VALUES
(1, 'Cambio de Aceite', 'Cambio de aceite y revisión general del motor', 80000.00, '1 Hora', 1),
(2, 'Ajuste de Frenos', 'Revisión y ajuste del sistema de frenos', 60000.00, '45 Minutos', 1),
(3, 'Diagnóstico Eléctrico', 'Escaneo y diagnóstico del sistema eléctrico', 120000.00, '2 Horas', 2),
(4, 'Mantenimiento Preventivo', 'Revisión completa y mantenimiento preventivo', 150000.00, '3 Horas', 3),
(5, 'Cambio de Kit de Arrastre', 'Cambio de cadena, piñón y catalina', 180000.00, '2 Horas', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taller`
--

CREATE TABLE `taller` (
  `id_taller` int(11) NOT NULL,
  `nombre_taller` varchar(100) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `horario_atencion` varchar(100) DEFAULT NULL,
  `capacidad_diaria` int(11) DEFAULT NULL,
  `estado_taller` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `taller`
--

INSERT INTO `taller` (`id_taller`, `nombre_taller`, `direccion`, `telefono`, `correo`, `horario_atencion`, `capacidad_diaria`, `estado_taller`) VALUES
(1, 'MotoSpeed Garage', 'Calle 80 # 20 - 15', '3204567890', 'motospeed@gmail.com', '8:00 AM - 6:00 PM', 15, 'ACTIVO'),
(2, 'FullMoto Service', 'Carrera 45 # 10 - 22', '3119876543', 'fullmoto@gmail.com', '7:30 AM - 5:30 PM', 10, 'ACTIVO'),
(3, 'PowerBike Taller', 'Avenida 68 # 45 - 90', '3006547891', 'powerbike@gmail.com', '8:00 AM - 7:00 PM', 20, 'ACTIVO'),
(4, 'Zona Rider Workshop', 'Calle 100 # 50 - 35', '3153459876', 'zonarider@gmail.com', '9:00 AM - 6:00 PM', 12, 'ACTIVO'),
(5, 'MotoTech Elite', 'Carrera 30 # 75 - 40', '3018765432', 'mototechelite@gmail.com', '8:00 AM - 5:00 PM', 18, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `tecnico` (
  `id_tecnico` int(11) NOT NULL,
  `nombre_tecnico` varchar(100) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_taller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `tecnico` (`id_tecnico`, `nombre_tecnico`, `especialidad`, `telefono`, `id_taller`) VALUES
(1, 'Carlos Ruiz', 'Mecánica General', '3209876541', 1),
(2, 'Andrés Torres', 'Sistema Eléctrico', '3114567890', 1),
(3, 'Jhon Martínez', 'Inyección Electrónica', '3008765432', 2),
(4, 'Sebastián Rojas', 'Frenos y Suspensión', '3157654321', 3),
(5, 'David Moreno', 'Diagnóstico y Escáner', '3016549870', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `rol` enum('CLIENTE','ADMIN') DEFAULT 'CLIENTE',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado_usuario` enum('ACTIVO','INACTIVO','BLOQUEADO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellido`, `correo`, `contraseña`, `telefono`, `direccion`, `rol`, `fecha_registro`, `estado_usuario`) VALUES
(1, 'Pedro', 'Perez', 'pedrope@gmail.com', 'Pedro123$', '3153234565', 'Calle 45 # 34 - 40', 'CLIENTE', '2026-01-03 05:00:00', 'ACTIVO'),
(2, 'Martin', 'Gomez', 'gomezmar@gmail.com', 'Martin455$', '3009634231', 'Calle 34 # 50 - 60', 'CLIENTE', '2026-05-05 05:00:00', 'ACTIVO'),
(3, 'Camila', 'Lopez', 'camilope@gmail.com', '345Camilita$', '3119804456', 'Carrera 89 # 24 - 10', 'CLIENTE', '2026-04-03 05:00:00', 'ACTIVO'),
(4, 'Paula', 'Puentes', 'paula34pue@gmail.com', 'Puentesroj34$', '3013457867', 'Carrera 15 # 30 - 20', 'CLIENTE', '2026-01-01 05:00:00', 'ACTIVO'),
(5, 'Michel', 'Buitrago', 'michelbutr@gmail.com', 'Bustragomichi$', '3150987854', 'Calle 123 # 67 - 90', 'CLIENTE', '2026-03-23 05:00:00', 'ACTIVO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_moto` (`id_moto`),
  ADD KEY `id_taller` (`id_taller`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`id_cotizacion`),
  ADD KEY `id_orden` (`id_orden`);

--
-- Indices de la tabla `moto`
--
ALTER TABLE `moto`
  ADD PRIMARY KEY (`id_moto`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `id_cita` (`id_cita`),
  ADD KEY `id_tecnico` (`id_tecnico`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_cotizacion` (`id_cotizacion`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_taller` (`id_taller`);

--
-- Indices de la tabla `taller`
--
ALTER TABLE `taller`
  ADD PRIMARY KEY (`id_taller`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`id_tecnico`),
  ADD KEY `id_taller` (`id_taller`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `moto`
--
ALTER TABLE `moto`
  MODIFY `id_moto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  MODIFY `id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `taller`
--
ALTER TABLE `taller`
  MODIFY `id_taller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `id_tecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_moto`) REFERENCES `moto` (`id_moto`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`),
  ADD CONSTRAINT `cita_ibfk_4` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE CASCADE;

--
-- Filtros para la tabla `moto`
--
ALTER TABLE `moto`
  ADD CONSTRAINT `moto_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD CONSTRAINT `orden_trabajo_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`),
  ADD CONSTRAINT `orden_trabajo_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnico` (`id_tecnico`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_cotizacion`) REFERENCES `cotizacion` (`id_cotizacion`);

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
