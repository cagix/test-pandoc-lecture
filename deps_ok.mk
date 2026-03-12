build/admin/images/architektur_cb.png: admin/images/architektur_cb.png
GFM_IMAGE_TARGETS += build/admin/images/architektur_cb.png

build/lecture/02-parsing/images/architektur_cb_parser.png: lecture/02-parsing/images/architektur_cb_parser.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/architektur_cb_parser.png

build/lecture/02-parsing/images/Def_PDA.png: lecture/02-parsing/images/Def_PDA.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/Def_PDA.png

build/lecture/02-parsing/images/pda2.png: lecture/02-parsing/images/pda2.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/pda2.png

build/lecture/02-parsing/images/LL-Parsertabelle.png: lecture/02-parsing/images/LL-Parsertabelle.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/LL-Parsertabelle.png

build/lecture/02-parsing/images/LL-Parser.png: lecture/02-parsing/images/LL-Parser.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/LL-Parser.png

build/lecture/02-parsing/images/hello_ex1.png: lecture/02-parsing/images/hello_ex1.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/hello_ex1.png

build/lecture/02-parsing/images/hello_ex2.png: lecture/02-parsing/images/hello_ex2.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/hello_ex2.png

build/lecture/02-parsing/images/ParserRuleContext.png: lecture/02-parsing/images/ParserRuleContext.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/ParserRuleContext.png

build/lecture/02-parsing/images/ParseTreeListener.png: lecture/02-parsing/images/ParseTreeListener.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/ParseTreeListener.png

build/lecture/02-parsing/images/ParseTreeVisitor.png: lecture/02-parsing/images/ParseTreeVisitor.png
GFM_IMAGE_TARGETS += build/lecture/02-parsing/images/ParseTreeVisitor.png

build/lecture/03-test/img/b.png: lecture/03-test/img/b.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/b.png

build/lecture/03-test/../02-parsing/images/bc_xml-parsing-error.png: lecture/03-test/../02-parsing/images/bc_xml-parsing-error.png
GFM_IMAGE_TARGETS += build/lecture/03-test/../02-parsing/images/bc_xml-parsing-error.png

build/lecture/03-test/../../admin/images/modulbeschreibung_ba.png: lecture/03-test/../../admin/images/modulbeschreibung_ba.png
GFM_IMAGE_TARGETS += build/lecture/03-test/../../admin/images/modulbeschreibung_ba.png

build/lecture/03-test/img/wuppie.png: lecture/03-test/img/wuppie.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/wuppie.png

build/lecture/03-test/img/dimensionen-ki.png: lecture/03-test/img/dimensionen-ki.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/dimensionen-ki.png

build/lecture/03-test/img/dimensionen-ki_light.png: lecture/03-test/img/dimensionen-ki_light.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/dimensionen-ki_light.png

build/lecture/03-test/img/dimensionen-ki_dark.png: lecture/03-test/img/dimensionen-ki_dark.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/dimensionen-ki_dark.png

build/lecture/03-test/img/test_transparentbackground.png: lecture/03-test/img/test_transparentbackground.png
GFM_IMAGE_TARGETS += build/lecture/03-test/img/test_transparentbackground.png

build/readme.md: readme.md
build/readme.md: build/admin/images/architektur_cb.png
GFM_MARKDOWN_TARGETS += build/readme.md
MARKDOWN_SRC += readme.md

NO_BEAMER += readme.md

build/lecture/02-parsing/readme.md: lecture/02-parsing/readme.md
build/lecture/02-parsing/readme.md: build/lecture/02-parsing/images/architektur_cb_parser.png
GFM_MARKDOWN_TARGETS += build/lecture/02-parsing/readme.md
MARKDOWN_SRC += lecture/02-parsing/readme.md

build/lecture/readme.md: lecture/readme.md
GFM_MARKDOWN_TARGETS += build/lecture/readme.md
MARKDOWN_SRC += lecture/readme.md

NO_PDF += lecture/readme.md

build/lecture/02-parsing/cfg.md: lecture/02-parsing/cfg.md
build/lecture/02-parsing/cfg.md: build/lecture/02-parsing/images/Def_PDA.png build/lecture/02-parsing/images/pda2.png build/lecture/02-parsing/images/LL-Parsertabelle.png build/lecture/02-parsing/images/LL-Parser.png
GFM_MARKDOWN_TARGETS += build/lecture/02-parsing/cfg.md
MARKDOWN_SRC += lecture/02-parsing/cfg.md

build/homework/readme.md: homework/readme.md
GFM_MARKDOWN_TARGETS += build/homework/readme.md
MARKDOWN_SRC += homework/readme.md

build/homework/sheet04.md: homework/sheet04.md
GFM_MARKDOWN_TARGETS += build/homework/sheet04.md
MARKDOWN_SRC += homework/sheet04.md

NO_BEAMER += homework/sheet04.md

build/lecture/02-parsing/antlr-parsing.md: lecture/02-parsing/antlr-parsing.md
build/lecture/02-parsing/antlr-parsing.md: build/lecture/02-parsing/images/hello_ex1.png build/lecture/02-parsing/images/hello_ex2.png build/lecture/02-parsing/images/ParserRuleContext.png build/lecture/02-parsing/images/ParseTreeListener.png build/lecture/02-parsing/images/ParseTreeVisitor.png
GFM_MARKDOWN_TARGETS += build/lecture/02-parsing/antlr-parsing.md
MARKDOWN_SRC += lecture/02-parsing/antlr-parsing.md

build/homework/sheet01.md: homework/sheet01.md
GFM_MARKDOWN_TARGETS += build/homework/sheet01.md
MARKDOWN_SRC += homework/sheet01.md

NO_BEAMER += homework/sheet01.md

build/homework/sheet02.md: homework/sheet02.md
GFM_MARKDOWN_TARGETS += build/homework/sheet02.md
MARKDOWN_SRC += homework/sheet02.md

NO_BEAMER += homework/sheet02.md

build/homework/sheet03.md: homework/sheet03.md
GFM_MARKDOWN_TARGETS += build/homework/sheet03.md
MARKDOWN_SRC += homework/sheet03.md

NO_BEAMER += homework/sheet03.md

build/lecture/03-test/readme.md: lecture/03-test/readme.md
GFM_MARKDOWN_TARGETS += build/lecture/03-test/readme.md
MARKDOWN_SRC += lecture/03-test/readme.md

NO_PDF += lecture/03-test/readme.md

NO_BEAMER += lecture/03-test/readme.md

build/lecture/03-test/test.md: lecture/03-test/test.md
build/lecture/03-test/test.md: build/lecture/03-test/img/b.png build/lecture/03-test/../02-parsing/images/bc_xml-parsing-error.png build/lecture/03-test/../../admin/images/modulbeschreibung_ba.png build/lecture/03-test/img/wuppie.png build/lecture/03-test/img/dimensionen-ki.png build/lecture/03-test/img/dimensionen-ki_light.png build/lecture/03-test/img/dimensionen-ki_dark.png build/lecture/03-test/img/test_transparentbackground.png
GFM_MARKDOWN_TARGETS += build/lecture/03-test/test.md
MARKDOWN_SRC += lecture/03-test/test.md

build/lecture/03-test/subfolder/foo.md: lecture/03-test/subfolder/foo.md
GFM_MARKDOWN_TARGETS += build/lecture/03-test/subfolder/foo.md
MARKDOWN_SRC += lecture/03-test/subfolder/foo.md

build/lecture/03-test/nn02-linear-regression.md: lecture/03-test/nn02-linear-regression.md
GFM_MARKDOWN_TARGETS += build/lecture/03-test/nn02-linear-regression.md
MARKDOWN_SRC += lecture/03-test/nn02-linear-regression.md

NO_BEAMER += lecture/03-test/nn02-linear-regression.md
