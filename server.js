// File: server.js
const Hapi = require('@hapi/hapi');
const mysql = require('mysql2/promise');
const { nanoid } = require('nanoid');
require('dotenv').config();

// Konfigurasi Database MySQL
const dbConfig = {
  host: 'localhost',
  user: 'root', // Ganti dengan username MySQL Anda
  password: '', // Ganti dengan password MySQL Anda
  database: 'hapi_books',
};

// Fungsi untuk koneksi database
async function connectDB() {
  const connection = await mysql.createConnection(dbConfig);
  return connection;
}

// Inisialisasi server
const init = async () => {
  const server = Hapi.server({
    port: 9000,
    host: 'localhost',
  });

  // ROUTE: Menambahkan buku
  server.route({
    method: 'POST',
    path: '/books',
    handler: async (request, h) => {
      const { name, year, author, summary, publisher, pageCount, readPage, reading } = request.payload;

      // Validasi jika readPage > pageCount
      if (readPage > pageCount) {
        return h.response({
          status: 'fail',
          message: 'readPage tidak boleh lebih besar dari pageCount',
        }).code(400);
      }

      const id = nanoid(16);
      const insertedAt = new Date();
      const updatedAt = insertedAt;
      const finished = pageCount === readPage;

      const query = `
        INSERT INTO books (id, name, year, author, summary, publisher, pageCount, readPage, finished, reading, insertedAt, updatedAt)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;

      try {
        const connection = await connectDB();
        await connection.execute(query, [
          id, name, year, author, summary, publisher, pageCount, readPage, finished, reading, insertedAt, updatedAt,
        ]);

        return h.response({
          status: 'success',
          message: 'Buku berhasil ditambahkan',
          data: { bookId: id },
        }).code(201);
      } catch (error) {
        console.error(error);
        return h.response({
          status: 'error',
          message: 'Terjadi kesalahan pada server',
        }).code(500);
      }
    },
  });

  // ROUTE: Mengambil semua buku
  server.route({
    method: 'GET',
    path: '/books',
    handler: async (req, res) => {
        const { name, reading, finished } = req.query; 
        try {
            const connection = await connectDB();
            let query = 'SELECT id, name, publisher FROM books';
            let paramsQuery = [];
            let isAddedWhere = false;
            if (name) {
                query += " WHERE name LIKE ?";
                paramsQuery.push(`%${name}%`);
                isAddedWhere = true;
            }
            if (reading) {
                query += isAddedWhere ? " " : " WHERE ";
                query += "reading = ?";
                paramsQuery.push(reading)
                isAddedWhere = true;
            }
            if (finished) {
                query += isAddedWhere ? " " : " WHERE ";
                query += "finished = ?";
                paramsQuery.push(finished)
                isAddedWhere = true;
            }
            const [rows] = await connection.execute(query, paramsQuery);
            return {
                status: 'success',
                data: { books: rows },
            };
        } catch (error) {
            console.error(error);
            return res.response({
                status: 'error',
                message: 'Terjadi kesalahan pada server',
            }).code(500);
        }
    }
});

  // ROUTE: Mengambil detail buku berdasarkan ID
  server.route({
    method: 'GET',
    path: '/books/{id}',
    handler: async (request, h) => {
      const { id } = request.params;
      const query = 'SELECT * FROM books WHERE id = ?';

      try {
        const connection = await connectDB();
        const [rows] = await connection.execute(query, [id]);

        if (rows.length === 0) {
          return h.response({
            status: 'fail',
            message: 'Buku tidak ditemukan',
          }).code(404);
        }

        return {
          status: 'success',
          data: { book: rows[0] },
        };
      } catch (error) {
        console.error(error);
        return h.response({
          status: 'error',
          message: 'Terjadi kesalahan pada server',
        }).code(500);
      }
    },
  });

  // ROUTE: Menghapus buku berdasarkan ID
  server.route({
    method: 'DELETE',
    path: '/books/{id}',
    handler: async (request, h) => {
      const { id } = request.params;
      const query = 'DELETE FROM books WHERE id = ?';

      try {
        const connection = await connectDB();
        const [result] = await connection.execute(query, [id]);

        if (result.affectedRows === 0) {
          return h.response({
            status: 'fail',
            message: 'Buku gagal dihapus. Id tidak ditemukan',
          }).code(404);
        }

        return {
          status: 'success',
          message: 'Buku berhasil dihapus',
        };
      } catch (error) {
        console.error(error);
        return h.response({
          status: 'error',
          message: 'Terjadi kesalahan pada server',
        }).code(500);
      }
    },
  });

  // Start server
  await server.start();
  console.log(`Server berjalan pada ${server.info.uri}`);
};

init();
