-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 17 Des 2024 pada 09.29
-- Versi server: 8.0.30
-- Versi PHP: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hapi_books`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `id` varchar(21) NOT NULL,
  `name` varchar(255) NOT NULL,
  `year` int NOT NULL,
  `author` varchar(255) NOT NULL,
  `summary` text,
  `publisher` varchar(255) DEFAULT NULL,
  `pageCount` int NOT NULL,
  `readPage` int NOT NULL,
  `finished` tinyint(1) NOT NULL,
  `reading` tinyint(1) NOT NULL,
  `insertedAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`id`, `name`, `year`, `author`, `summary`, `publisher`, `pageCount`, `readPage`, `finished`, `reading`, `insertedAt`, `updatedAt`) VALUES
('n0a1b2c3d4e5f6g7h8i9', 'Buku J', 2020, 'Hannah Pink', 'Excepteur sint occaecat cupidatat', 'Media Kita', 220, 150, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n1a2b3c4d5e6f7g8h9i0', 'Buku A', 2011, 'Jane Doe', 'Lorem Dolor sit Amet', 'Dicoding', 200, 26, 0, 0, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n2b3c4d5e6f7g8h9i0a1', 'Buku B', 2012, 'John Smith', 'Consectetur adipiscing elit', 'Gramedia', 300, 150, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n3c4d5e6f7g8h9i0a1b2', 'Buku C', 2013, 'Alice Brown', 'Sed do eiusmod tempor', 'Media Kita', 150, 150, 1, 0, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n4d5e6f7g8h9i0a1b2c3', 'Buku D', 2014, 'Bob White', 'Ut labore et dolore magna', 'Pustaka Baru', 250, 50, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n5e6f7g8h9i0a1b2c3d4', 'Buku E', 2015, 'Charlie Green', 'Aliqua Ut enim ad minim', 'Andi Publisher', 400, 100, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n6f7g8h9i0a1b2c3d4e5', 'Buku F', 2016, 'David Blue', 'Quis nostrud exercitation ullamco', 'Erlangga', 100, 100, 1, 0, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n7g8h9i0a1b2c3d4e5f6', 'Buku G', 2017, 'Emily Yellow', 'Laboris nisi ut aliquip ex ea', 'Gramedia', 350, 200, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n8h9i0a1b2c3d4e5f6g7', 'Buku H', 2018, 'Frank Black', 'Duis aute irure dolor in', 'Pustaka Lama', 500, 250, 0, 1, '2024-12-17 15:36:33', '2024-12-17 15:36:33'),
('n9i0a1b2c3d4e5f6g7h8', 'Buku I', 2019, 'Grace Red', 'Reprehenderit in voluptate', 'Bukuku', 120, 120, 1, 0, '2024-12-17 15:36:33', '2024-12-17 15:36:33');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
