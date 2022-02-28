;;; Expert System untuk diagnosis gangguan pada kesehatan mental
;;; Nama: Vallentina Wahyu Febrihartanti
;;; NIM	: 20/456851/TK/50675

;identifikasi apakah pasien dalam pengaruh obat
(defrule inMed
	=>
	(printout t crlf "Apakah anda dalam pengaruh obat-obatan? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 0)
		then(assert(inMed no))
	)(if (= ?x 1)
		then(printout t crlf "Anda sedang dalam pengaruh obat-obatan." crlf))
)

;identifikasi apakah pasien memiliki gejala psikologis
(defrule gejalapsikologis 
	(inMed no)
	=>
	(printout t crlf "Apakah anda mengalami gejala psikologis? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then (assert (gejalapsikologis yes))
	)(if (= ?x 0)
		then(assert (gejalapsikologis no)))
)

;;;******************************************
;;;* Only Execute when gejalapsikologis yes *
;;;******************************************

(defrule gejalafisik 
	(gejalapsikologis yes)
	=>
	(printout t crlf "Apakah anda mengalami gejala fisik seperti pusing, hilang tenaga, dll? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalafisik yes))
	) (if(= ?x 0)
		then(assert (gejalafisik no)))
)

(defrule gangguanPanik
	(gejalafisik yes)
	=>
	(printout t crlf "Apakah anda sering merasa cemas tanpa sebab? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(printout t crlf "Anda mengalami gangguan panik. Silakan hubungi psikolog/psikiater." crlf)
	)(if (= ?x 0)
		then (printout t crlf "Normal namun bergejala." crlf))
)	

(defrule gangguanCampuran
	(gejalafisik no)
	=>
	(printout t crlf "Apakah anda merasa cemas ketika berpergian sendiri? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then (printout t crlf "Apakah anda sering mengalami overaktivitas otonomik (contoh: nafas pendek, telapak tangan basah, jantung berdebar, dll)? (0:no/1:yes) " crlf)
		(bind ?x (read))
		(if (= ?x 1) 
			then(printout t crlf "Apakah anda sering mengalami stress seolah olah hidup anda penuh masalah? (0:no/1:yes) " crlf)
			(bind ?x (read))
			(if (= ?x 1)
				then(printout t crlf "Anda mengalami gangguan campuran anxietas dan depresi. Silakan hubungi psikolog/psikiater." crlf)
			)(if (= ?x 0) 
				then(printout t crlf "Normal namun bergejala." crlf))	
		)(if (= ?x 0) 
			then (printout t crlf "Normal namun bergejala." crlf))
	) (if (= ?x 0)
		then (printout t crlf "Normal namun bergejala." crlf))		
)

;;;******************************************
;;;* Only Execute when gejalapsikologis no *
;;;******************************************		

(defrule gejalakonsentrasi
	(gejalapsikologis no)
	=>
	(printout t crlf "Apakah konsentrasi anda sering terganggu? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalakonsentrasi yes))
	)(if (= ?x 0)
		then(assert (gejalakonsentrasi no)))
)

;;; this will be executed when gejalakonsentrasi yes
(defrule gejalakhawatir
	(gejalakonsentrasi yes)
	=>
	(printout t crlf "Apakah anda memiliki kekhawatiran akan nasib buruk? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalakhawatir yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda tidak memiliki gangguan pada kesehatan mental." crlf)
	)
)

(defrule gejaladeptemp
	(gejalakhawatir yes)
	=>
	(printout t crlf "Apakah anda terlihat depresi yang bersifat sementara? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejaladeptemp yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda tidak memiliki gangguan pada kesehatan mental." crlf)
	)
)

(defrule gejalategangmotorik
	(gejaladeptemp yes)
	=>
	(printout t crlf "Apakah anda sering mengalami ketegangan motorik? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalategangmotorik yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal namun memiliki gejala. Hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gejalaovermotorik
	(gejalategangmotorik yes)
	=>
	(printout t crlf "Apakah anda sering mengalami overaktivitas otonomik (contoh: nafas pendek, telapak tangan basah, jantung berdebar, dll)? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaovermotorik yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal namun memiliki gejala. Hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)		

(defrule gejalacantcalm
	(gejalaovermotorik yes)
	=>
	(printout t crlf "Apakah anda merasa memiliki kebutuhan berlebih untuk ditenangkan saat cemas? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalacantcalm yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal namun memiliki gejala. Hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)	

(defrule gejala1month
	(gejalacantcalm yes)
	=>
	(printout t crlf "Apakah gejala yang anda alami tampak selama 1 bulan? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejala1month yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala. Hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gejalaeveryday
	(gejala1month yes)
	=>
	(printout t crlf "Apakah gejala yang anda alami muncul setiap hari? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaeveryday yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental anda. Hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gangguanCemas
	(gejalakhawatir yes)
	(gejaladeptemp yes)
	(gejalategangmotorik yes)
	(gejalaovermotorik yes)
	(gejalacantcalm yes)
	(gejala1month yes)
	(gejalaeveryday yes)
	=>
	(printout t crlf "Anda memiliki gangguan cemas menyeluruh. Silakan hubungi psikolog/psikiater untuk diagnosa dan pengobatan lebih lanjut." crlf)
)

;;; this will be executed when gejalakonsentrasi no
(defrule gejalaafekdepresif
	(gejalakonsentrasi no)
	=>
	(printout t crlf "Apakah anda sering memiliki afek depresif? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaafekdepresif yes))
	)(if (= ?x 0)
		then(assert (gejalaafekdepresif no))
	)
)

;;only execute when gejalaafekdepresif yes
(defrule gejalaloseminat
	(gejalaafekdepresif yes)
	=>
	(printout t crlf "Apakah anda sering kehilangan minat dan kegembiraan? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaloseminat yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejalamudahlelah
	(gejalaloseminat yes)
	=>
	(printout t crlf "Apakah anda sering mudah lelah? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalamudahlelah yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejalalosekonsen
	(gejalamudahlelah yes)
	=>
	(printout t crlf "Apakah konsentrasi dan perhatian anda berkurang? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalalosekonsen yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejalaactlancar
	(gejalalosekonsen yes)
	=>
	(printout t crlf "Apakah kelancaran aktivitas anda menjadi terdampak? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaactlancar yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejalaoverotonomik
	(gejalaactlancar yes)
	=>
	(printout t crlf "Apakah anda sering mengalami overaktivitas otonomik (contoh: nafas pendek, telapak tangan basah, jantung berdebar, dll)? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaoverotonomik yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejalasetiaphari
	(gejalaoverotonomik yes)
	=>
	(printout t crlf "Apakah gejala ini muncul setiap hari? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalasetiaphari yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut."crlf)
	)
)

(defrule gejalastress
	(gejalasetiaphari yes)
	=>
	(printout t crlf "Apakah anda sering stress seolah merasa kehidupan yang penih masalah ? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalastress yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gejalatidur
	(gejalastress yes)
	=>
	(printout t crlf "Apakah tidur anda sering terganggu? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalatidur yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gejalaappetite
	(gejalatidur yes)
	=>
	(printout t crlf "Apakah nafsu makan anda berkurang akhir-akhir ini? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaappetite yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gejala2weeks
	(gejalaappetite yes)
	=>
	(printout t crlf "Apakah anda mengalami gangguan tersebut selama kurang lebih 2 minggu? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejala2weeks yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gangguanDepresi
	(gejalaafekdepresif yes)
	(gejalaloseminat yes)
	(gejalamudahlelah yes)
	(gejalalosekonsen yes)
	(gejalaactlancar yes)
	(gejalaoverotonomik yes)
	(gejalasetiaphari yes)
	(gejalastress yes)
	(gejalatidur yes)
	(gejalaappetite yes)
	(gejala2weeks yes)
	=>
	(printout t crlf "Anda memiliki gangguan depresi. Silakan hubungi psikolog/psikiater untuk diagnosa dan pengobatan lebih lanjut." crlf)
)

;;only execute when gejalaafekdepresif no
(defrule gejalaafekmeninggi
	(gejalaafekdepresif no)
	=>
	(printout t crlf "Apakah anda memiliki afek meninggi atau berubah? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaafekmeninggi yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda tidak memiliki gangguan pada kesehatan mental." crlf)
	)
)

(defrule gejalaafekmeninggi
	(gejalaafekdepresif no)
	=>
	(printout t crlf "Apakah anda memiliki afek meninggi atau berubah? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalaafekmeninggi yes))
	)(if (= ?x 0)
		then(assert (gejalaafekmeninggi no))
	)
)

;only execute when gejalaafekmeninggi yes
(defrule gejalahighact
	(gejalaafekmeninggi yes)
	=>
	(printout t crlf "Apakah anda memiliki peningkatan aktivitas? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalahighact yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda tidak memiliki gangguan pada kesehatan mental." crlf)
	)
)

(defrule gejalatiaphari
	(gejalahighact yes)
	=>
	(printout t crlf "Apakah gejala tampak setiap hari? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejalatiaphari yes))
	)(if (= ?x 0)
		then(printout t crlf "Normal dengan beberapa gejala." crlf)
	)
)

(defrule gejaladampact
	(gejalatiaphari yes)
	=>
	(printout t crlf "Apakah gejala memberikan dampak pada kelancaran aktivitas? (0:no/1:yes) " crlf)
	(bind ?x (read))
	(if (= ?x 1)
		then(assert (gejaladampact yes))
	)(if (= ?x 0)
		then(printout t crlf "Anda memiliki gejala gangguan pada kesehatan mental. Silakan hubungi psikolog/psikiater untuk diagnosa lebih lanjut." crlf)
	)
)

(defrule gangguanBipolar
	(gejalaafekmeninggi yes)
	(gejalahighact yes)
	(gejalatiaphari yes)
	(gejaladampact yes)
	=>
	(printout t crlf "Anda memiliki gangguan bipolar. Silakan hubungi psikolog/psikiater untuk diagnosa dan pengobatan lebih lanjut." crlf)
)

;this will be executed when gejalaafekmeninggi no

(defrule normal
	(gejalapsikologis no)
	(gejalakonsentrasi no)
	(gejalaafekdepresif no)
	(gejalaafekmeninggi no)
	=>
	(printout t crlf "Anda tidak memiliki gangguan pada kesehatan mental. Sehat selalu." crlf)
)
