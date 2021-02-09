-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Feb 2021 pada 08.55
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_sevima`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 5),
(1, 'App\\User', 85),
(1, 'App\\User', 87),
(1, 'App\\User', 88),
(1, 'App\\User', 89),
(1, 'App\\User', 90),
(1, 'App\\User', 91),
(1, 'App\\User', 92),
(2, 'App\\User', 8),
(2, 'App\\User', 10),
(2, 'App\\User', 47);

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'read-absensi', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(2, 'read-pengguna', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(3, 'create-pengguna', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(4, 'edit-pengguna', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(5, 'delete-pengguna', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(6, 'read-404', 'web', '2020-09-01 19:57:21', '2020-09-01 19:57:21'),
(7, 'dashboard-total-karyawan', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(8, 'dashboard-kehadiran', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(9, 'dashboard-keterlambatan', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(10, 'read-data-kehadiran', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(11, 'create-data-kehadiran', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(12, 'edit-data-kehadiran', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(13, 'delete-data-kehadiran', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(14, 'read-lacak', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(15, 'read-pantau', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(16, 'export-pdf-laporan-absensi', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(17, 'export-xls-laporan-absensi', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(18, 'export-pdf-rekap-absensi', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(19, 'export-xls-rekap-absensi', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(20, 'export-pdf-rekap-keterlambatan', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(21, 'export-xls-rekap-keterlambatan', 'web', '2020-08-31 18:49:26', '2020-08-31 18:49:26'),
(22, 'read-karyawan', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(23, 'create-karyawan', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(24, 'edit-karyawan', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(25, 'delete-karyawan', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(26, 'read-role', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(27, 'create-role', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(28, 'edit-role', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(29, 'delete-role', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(30, 'read-lokasi', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(31, 'create-lokasi', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(32, 'edit-lokasi', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(33, 'delete-lokasi', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(34, 'read-divisi', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(35, 'create-divisi', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(36, 'edit-divisi', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(37, 'delete-divisi', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(38, 'read-jabatan', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(39, 'create-jabatan', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(40, 'edit-jabatan', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(41, 'delete-jabatan', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(42, 'read-kantor', 'web', '2020-09-01 19:57:18', '2020-09-01 19:57:18'),
(43, 'create-kantor', 'web', '2020-09-01 19:57:19', '2020-09-01 19:57:19'),
(44, 'edit-kantor', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20'),
(45, 'delete-kantor', 'web', '2020-09-01 19:57:20', '2020-09-01 19:57:20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `posting`
--

CREATE TABLE `posting` (
  `id` int(11) NOT NULL,
  `post_content` text NOT NULL,
  `url_post` varchar(100) NOT NULL,
  `created_by` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `image` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `posting`
--

INSERT INTO `posting` (`id`, `post_content`, `url_post`, `created_by`, `datetime`, `image`, `created_at`, `updated_at`) VALUES
(1, 'test 123', 'test_123', 5, '2021-02-08 19:21:06', '', '2021-02-08 19:21:06', '2021-02-08 19:21:06'),
(2, 'test 2345', 'test_2345', 5, '2021-02-08 19:21:57', '', '2021-02-08 19:21:57', '2021-02-08 19:21:57'),
(4, 'test 657', 'test-657', 5, '2021-02-08 19:28:11', 'TEST-657.jpeg', '2021-02-08 19:28:11', '2021-02-08 19:28:11'),
(6, 'hallo', 'hallo', 5, '2021-02-08 20:10:51', 'HALLO.jpeg', '2021-02-08 20:10:51', '2021-02-08 20:10:51'),
(7, 'sayangku', 'sayangku', 5, '2021-02-08 20:14:13', 'SAYANGKU.jpeg', '2021-02-08 20:14:13', '2021-02-08 20:14:13'),
(8, 'aku lagi ngetes upload komentar dengan foto', 'aku-lagi-ngetes-upload-komentar-dengan-foto', 5, '2021-02-08 20:33:39', 'AKU-LAGI-NGETES-UPLOAD-KOMENTAR-DENGAN-FOTO.jpeg', '2021-02-08 20:33:39', '2021-02-08 20:33:39'),
(11, 'ryan lg ngetes aplikasi', 'ryan_lg_ngetes_aplikasi', 85, '2021-02-08 23:07:26', '', '2021-02-08 23:07:26', '2021-02-08 23:07:26'),
(14, 'sisca test posting', 'sisca-test-posting', 87, '2021-02-09 01:56:11', 'SISCA-TEST-POSTING.png', '2021-02-09 01:56:11', '2021-02-09 01:56:11'),
(15, 'aisyah tes status', 'aisyah-tes-status', 88, '2021-02-09 08:48:19', 'AISYAH-TES-STATUS.jpeg', '2021-02-09 08:48:19', '2021-02-09 08:48:19'),
(16, 'posting test', 'posting_test', 91, '2021-02-09 14:36:31', '', '2021-02-09 14:36:31', '2021-02-09 14:36:31'),
(17, 'posting test dengan gambar', 'posting-test-dengan-gambar', 91, '2021-02-09 14:36:53', 'POSTING-TEST-DENGAN-GAMBAR.png', '2021-02-09 14:36:53', '2021-02-09 14:36:53'),
(19, 'text dan gambar', 'text-dan-gambar', 92, '2021-02-09 14:44:51', 'TEXT-DAN-GAMBAR.png', '2021-02-09 14:44:51', '2021-02-09 14:44:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `posting_comment`
--

CREATE TABLE `posting_comment` (
  `id` int(11) NOT NULL,
  `id_post` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `comment` text NOT NULL,
  `datetime` datetime NOT NULL,
  `status` enum('0','1') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `posting_comment`
--

INSERT INTO `posting_comment` (`id`, `id_post`, `id_user`, `comment`, `datetime`, `status`, `created_at`, `updated_at`) VALUES
(2, 12, 85, '', '2021-02-09 00:51:15', '1', '2021-02-09 00:10:01', '2021-02-09 00:51:15'),
(3, 12, 85, 'ooowowow', '2021-02-09 00:57:19', '1', '2021-02-09 00:10:44', '2021-02-09 00:57:19'),
(5, 8, 85, 'bagus bro', '2021-02-09 00:29:56', '1', '2021-02-09 00:29:56', '2021-02-09 00:29:56'),
(6, 12, 85, 'yes lah', '2021-02-09 01:05:18', '1', '2021-02-09 01:05:18', '2021-02-09 01:05:18'),
(7, 8, 85, 'teslah ya', '2021-02-09 01:06:38', '1', '2021-02-09 01:06:38', '2021-02-09 01:06:38'),
(8, 14, 5, 'mantap yung', '2021-02-09 01:57:44', '1', '2021-02-09 01:57:44', '2021-02-09 01:57:44'),
(9, 14, 85, 'iyalah mantap', '2021-02-09 01:59:19', '1', '2021-02-09 01:59:19', '2021-02-09 01:59:19'),
(10, 14, 87, 'punya aku lah', '2021-02-09 01:59:47', '1', '2021-02-09 01:59:47', '2021-02-09 01:59:47'),
(11, 17, 91, 'lg ngetes bang', '2021-02-09 14:37:22', '1', '2021-02-09 14:37:22', '2021-02-09 14:37:22'),
(14, 17, 92, 'komentar', '2021-02-09 14:46:38', '1', '2021-02-09 14:46:38', '2021-02-09 14:46:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `posting_like`
--

CREATE TABLE `posting_like` (
  `id` int(11) NOT NULL,
  `id_post` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `status` enum('0','1') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `posting_like`
--

INSERT INTO `posting_like` (`id`, `id_post`, `id_user`, `datetime`, `status`, `created_at`, `updated_at`) VALUES
(1, 8, 5, '2021-02-08 23:18:19', '1', '2021-02-08 22:41:36', '2021-02-08 23:18:19'),
(2, 7, 5, '2021-02-08 23:02:28', '1', '2021-02-08 22:46:28', '2021-02-08 23:02:28'),
(3, 1, 5, '2021-02-08 22:59:30', '1', '2021-02-08 22:59:30', '2021-02-08 22:59:30'),
(4, 6, 5, '2021-02-08 23:02:25', '1', '2021-02-08 23:02:25', '2021-02-08 23:02:25'),
(5, 2, 5, '2021-02-08 23:18:24', '0', '2021-02-08 23:02:30', '2021-02-08 23:18:24'),
(6, 8, 85, '2021-02-08 23:07:17', '1', '2021-02-08 23:07:17', '2021-02-08 23:07:17'),
(7, 1, 85, '2021-02-08 23:08:01', '1', '2021-02-08 23:08:01', '2021-02-08 23:08:01'),
(8, 12, 5, '2021-02-08 23:57:44', '0', '2021-02-08 23:08:48', '2021-02-08 23:57:44'),
(9, 12, 85, '2021-02-09 00:30:30', '1', '2021-02-09 00:30:30', '2021-02-09 00:30:30'),
(10, 14, 87, '2021-02-09 01:57:15', '1', '2021-02-09 01:57:15', '2021-02-09 01:57:15'),
(11, 14, 5, '2021-02-09 01:57:35', '1', '2021-02-09 01:57:35', '2021-02-09 01:57:35'),
(12, 14, 85, '2021-02-09 01:58:11', '1', '2021-02-09 01:58:11', '2021-02-09 01:58:11'),
(13, 14, 88, '2021-02-09 02:08:36', '1', '2021-02-09 02:08:36', '2021-02-09 02:08:36'),
(14, 15, 87, '2021-02-09 08:48:51', '1', '2021-02-09 08:48:51', '2021-02-09 08:48:51'),
(15, 17, 91, '2021-02-09 14:37:05', '1', '2021-02-09 14:37:05', '2021-02-09 14:37:05'),
(16, 15, 91, '2021-02-09 14:37:59', '1', '2021-02-09 14:37:59', '2021-02-09 14:37:59'),
(17, 14, 91, '2021-02-09 14:38:55', '1', '2021-02-09 14:38:03', '2021-02-09 14:38:55'),
(18, 19, 92, '2021-02-09 14:45:00', '1', '2021-02-09 14:45:00', '2021-02-09 14:45:00'),
(19, 17, 92, '2021-02-09 14:46:20', '1', '2021-02-09 14:46:20', '2021-02-09 14:46:20'),
(20, 15, 92, '2021-02-09 14:46:56', '1', '2021-02-09 14:46:56', '2021-02-09 14:46:56'),
(21, 14, 92, '2021-02-09 14:47:02', '1', '2021-02-09 14:47:02', '2021-02-09 14:47:02');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2020-08-31 18:42:38', '2020-08-31 18:42:38'),
(2, 'hrd', 'web', '2020-08-31 18:45:16', '2020-10-01 19:01:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_menus`
--

CREATE TABLE `role_has_menus` (
  `id` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  `menus` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `role_has_menus`
--

INSERT INTO `role_has_menus` (`id`, `id_role`, `menus`) VALUES
(1, 1, '[\r\n{\"href\":\"\\/\",\"title\":\"Beranda\",\"icon\":\"fa fa-home\"}]');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(6, 2),
(7, 1),
(7, 2),
(8, 1),
(8, 2),
(9, 1),
(9, 2),
(10, 1),
(10, 2),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(13, 1),
(13, 2),
(14, 1),
(14, 2),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(17, 1),
(17, 2),
(18, 1),
(18, 2),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(21, 1),
(21, 2),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_depan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_belakang` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '$2y$10$6oOf6pDJY39NddoQzJ/uEucR4/7E.IxIzIzJOlbXb/Q3JoLvuGtYa',
  `foto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nama_depan`, `nama_belakang`, `no_telp`, `email`, `email_verified_at`, `password`, `foto`, `remember_token`, `created_at`, `updated_at`) VALUES
(5, 'Super Admin', '', '085654343456', 'superadmin@gmail.com', NULL, '$2y$10$GrcRMoq8LOFLlWwJmkVx..kzmdm6S6qC4YcYOUXKIOmw2CYeD2yOC', '', NULL, '2020-08-24 19:57:46', '2020-10-01 19:24:22'),
(85, 'Ryan ', 'Saputro', '085654343456', 'ryan@gmail.com', NULL, '$2y$10$GrcRMoq8LOFLlWwJmkVx..kzmdm6S6qC4YcYOUXKIOmw2CYeD2yOC', '', NULL, '2020-08-24 19:57:46', '2020-10-01 19:24:22'),
(87, 'sisca', 'ningtyas', '085649184363', 'sisca@gmail.com', NULL, '$2y$10$RVX10zdrgXuc9DYDy5EBR.zHJqO4j2Bvlu/7tSJXLbjuftNyvAfDa', 'SISCA.png', NULL, '2021-02-08 18:29:59', '2021-02-08 18:29:59'),
(88, 'aisyah', 'abidah', '085649184363', 'aisyah@gmail.com', NULL, '$2y$10$tXU2GKsRzjfKeQtVuceQA.oU7wsdHpEvTmQucOu3c4vq6wwPTZx.m', 'AISYAH.jpeg', NULL, '2021-02-08 19:07:02', '2021-02-08 19:07:02'),
(89, 'momo', 'geisha', '085434321234', 'momo@gmail.com', NULL, '$2y$10$CqEJkqmPTHBXT0bc4oH4UelPng5dOE1YDfpzpBFA5NeLHuppnmTEu', '.png', NULL, '2021-02-09 07:28:20', '2021-02-09 07:28:20'),
(90, 'abc', 'def', '087654543234', 'abc@gmail.com', NULL, '$2y$10$iJaTTEBwIjRsiB540b/mnOiJNjLH2I2uHFJwzkhSEC3p/FagTLkEi', '.png', NULL, '2021-02-09 07:34:28', '2021-02-09 07:34:28'),
(91, 'boges', 'sanjaya', '086544342345', 'boges@gmail.com', NULL, '$2y$10$FzkyoNJ3M8lcAjEEnUsVtuvWAh/3mO.Rn/UCJELgxcFAynhlUj7G6', 'BOGES.png', NULL, '2021-02-09 07:35:52', '2021-02-09 07:35:52'),
(92, 'koko', 'kenya', '086543212345', 'koko@gmail.com', NULL, '$2y$10$MUopYC7qO0zUr0iJ8i9J8e0DdcLZk1tNW27OVB13ysElkodvtCWlK', 'KOKO.png', NULL, '2021-02-09 07:43:51', '2021-02-09 07:43:51');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `posting`
--
ALTER TABLE `posting`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `posting_comment`
--
ALTER TABLE `posting_comment`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `posting_like`
--
ALTER TABLE `posting_like`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `role_has_menus`
--
ALTER TABLE `role_has_menus`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `posting`
--
ALTER TABLE `posting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `posting_comment`
--
ALTER TABLE `posting_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `posting_like`
--
ALTER TABLE `posting_like`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `role_has_menus`
--
ALTER TABLE `role_has_menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
