class Question {
  final int id, answer; //variabel menyimpan id pertanyaan dan jawaban 
  final String? image; //variabel menyimpan url gambar terkait pertanyaan 
  final String question; //variabel menyimpan text dari pertanyaan 
  final List<String> options; //variabel menyimpan daftar opsi jawaban 

//konstruktor untuk menginisialisasi objek pertanyaan 
  Question({required this.id, required this.question, this.image, required this.answer, required this.options});
}

//data pertanyaan yang digunakan 
const List sample_data = [
  {
    "id": 1,
    "question":
      'Ada berapa Fakultas yang ada di UNESA?' ,//pertanyaan 
    "options": ['10', '7','16', '20', '12'],//opsi jawaban 
    "answer_index": 0,//indeks jawaban yang benar 
  },
  {
    "id": 2,
    "question": 
        'Unesa terbagi menjadi berapa kampus?',
    "options": ['4', '5', '7', '3', '1'],
    "answer_index": 3,
  },
  {
    "id": 3,
    "question":
        'Dimana letak kampus terbaru UNESA?',
    "options": ['Lidah wetan', 'Ketintang', 'Magetan', 'Surabaya', 'Gresik'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "image": "images/cakhasan.jpg",//url gambar yang terkait pertanyaan 
    "question":
        'Siapa nama bapak rektor UNESA?',//pertanyaan 
    "options": ['Cak Hasan', 'Cak Husni', 'Cak Husain', 'Cak Hasna', 'Cak Haisan'],//opsi jawaban
    "answer_index": 0,//indeks jawaban yang benar 
  },
  {
    "id": 5,
    "question": 'Ada berapa fakultas di kampus ketintang?',
    "options": ['7', '6', '5', '10', '11'],
    "answer_index": 1,
  },
  {
    "id": 6,
    "question": 'Fakultas apa yang menaungi jenjang diploma?',
    "options": ['FMIPA', 'FEB', 'VOKASI', 'Teknik', 'Fisipol'],
    "answer_index": 2,
  },
  {
    "id": 7,
    "question": 'Siapa dekan fakultas vokasi?',
    "options": ['Dr. Bambang Sigit Widodo, M.Pd.', 'Prof. Dr. Wasis, M.Si.', 'Syafi’ul Anam, Ph.D', 'Prof. Dr. Muhamad Nursalim, M.Si.', 'Suprapto, S.Pd., M.T.,'],
    "answer_index": 4,
  },
  {
    "id": 8,
    "question": 'Tahun berapa fakultas vokasi berdiri?',
    "options": ['2020', '2019', '2021', '2022', '2023'],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question": 'Ada berapa prodi di fakultas vokasi ?',
    "options": ['9', '8', '6', '10', '7'],
    "answer_index": 3,
  },
  {
    "id": 10,
    "question": 'Ruang Tu berada di Gedung apa?',
    "options": ['K2', 'K3', 'K6', 'K9', 'K10'],
    "answer_index": 3,
  },
];