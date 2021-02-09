(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[1],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/Register.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/Register.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      form: {
        nama_depan: '',
        nama_belakang: '',
        no_telp: '',
        email: '',
        password: '',
        password_confirmation: '',
        foto: ''
      },
      has_error: false,
      error: '',
      errors: {},
      success: false,
      loading: false
    };
  },
  methods: {
    onFileChange: function onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files;
      if (!files.length) return;
      this.createImage(files[0]);
    },
    createImage: function createImage(file) {
      var image = new Image();
      var reader = new FileReader();
      var vm = this;

      reader.onload = function (e) {
        vm.form.foto = e.target.result;
        console.log(vm.foto);
      };

      reader.readAsDataURL(file);
    },
    removeImage: function removeImage(e) {
      this.form.foto = '';
    },
    register: function register() {
      this.loading = true;
      var app = this.form;
      this.$auth.register({
        data: _defineProperty({
          nama_depan: app.nama_depan,
          nama_belakang: app.nama_belakang,
          no_telp: app.no_telp,
          email: app.email,
          password: app.password,
          password_confirmation: app.password_confirmation,
          foto: app.foto
        }, "password_confirmation", app.password_confirmation),
        success: function success() {
          this.loading = false;
          app.success = true;
          this.$router.push({
            name: 'login',
            params: {
              successRegistrationRedirect: true
            }
          });
        },
        error: function error(res) {
          // console.log(res.response.data.errors)
          app.has_error = true;
          app.error = res.response.data.error;
          app.errors = res.response.data.errors || {};
        }
      });
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/Register.vue?vue&type=template&id=364a2fac&":
/*!******************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/Register.vue?vue&type=template&id=364a2fac& ***!
  \******************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "render", function() { return render; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return staticRenderFns; });
var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c("div", { staticClass: "container" }, [
    _c("div", { staticClass: "row justify-content-md-center" }, [
      _c("div", { staticClass: "col-6" }, [
        _c("div", { staticClass: "card card-default" }, [
          _c("div", { staticClass: "card-header" }, [_vm._v("Register")]),
          _vm._v(" "),
          _c("div", { staticClass: "card-body" }, [
            _vm.has_error && !_vm.success
              ? _c("div", { staticClass: "alert alert-danger" }, [
                  _vm.error == "registration_validation_error"
                    ? _c("p", [_vm._v("Validation Errors.")])
                    : _c("p", [
                        _vm._v(
                          "Error, can not register at the moment. If the problem persists, please contact an administrator."
                        )
                      ])
                ])
              : _vm._e(),
            _vm._v(" "),
            !_vm.success
              ? _c(
                  "form",
                  {
                    attrs: { autocomplete: "off", method: "post" },
                    on: {
                      submit: function($event) {
                        $event.preventDefault()
                        return _vm.register($event)
                      }
                    }
                  },
                  [
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.nama_depan
                        }
                      },
                      [
                        _c("label", { attrs: { for: "nama_depan" } }, [
                          _vm._v("Nama Depan")
                        ]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.nama_depan,
                              expression: "form.nama_depan"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: {
                            type: "text",
                            id: "nama_depan",
                            placeholder: "Nama Depan"
                          },
                          domProps: { value: _vm.form.nama_depan },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(
                                _vm.form,
                                "nama_depan",
                                $event.target.value
                              )
                            }
                          }
                        }),
                        _vm._v(" "),
                        _vm.has_error && _vm.errors.nama_depan
                          ? _c("span", { staticClass: "help-block" }, [
                              _vm._v(_vm._s(_vm.errors.nama_depan))
                            ])
                          : _vm._e()
                      ]
                    ),
                    _vm._v(" "),
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.nama_depan
                        }
                      },
                      [
                        _c("label", { attrs: { for: "nama_belakang" } }, [
                          _vm._v("Nama Belakang")
                        ]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.nama_belakang,
                              expression: "form.nama_belakang"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: {
                            type: "text",
                            id: "nama_belakang",
                            placeholder: "Nama Belakang"
                          },
                          domProps: { value: _vm.form.nama_belakang },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(
                                _vm.form,
                                "nama_belakang",
                                $event.target.value
                              )
                            }
                          }
                        }),
                        _vm._v(" "),
                        _vm.has_error && _vm.errors.nama_belakang
                          ? _c("span", { staticClass: "help-block" }, [
                              _vm._v(_vm._s(_vm.errors.nama_belakang))
                            ])
                          : _vm._e()
                      ]
                    ),
                    _vm._v(" "),
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.nama_depan
                        }
                      },
                      [
                        _c("label", { attrs: { for: "no_telp" } }, [
                          _vm._v("No Telp")
                        ]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.no_telp,
                              expression: "form.no_telp"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: {
                            type: "text",
                            id: "no_telp",
                            placeholder: "No Telp"
                          },
                          domProps: { value: _vm.form.no_telp },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(_vm.form, "no_telp", $event.target.value)
                            }
                          }
                        }),
                        _vm._v(" "),
                        _vm.has_error && _vm.errors.no_telp
                          ? _c("span", { staticClass: "help-block" }, [
                              _vm._v(_vm._s(_vm.errors.no_telp))
                            ])
                          : _vm._e()
                      ]
                    ),
                    _vm._v(" "),
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.email
                        }
                      },
                      [
                        _c("label", { attrs: { for: "email" } }, [
                          _vm._v("E-mail")
                        ]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.email,
                              expression: "form.email"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: {
                            type: "email",
                            id: "email",
                            placeholder: "user@example.com"
                          },
                          domProps: { value: _vm.form.email },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(_vm.form, "email", $event.target.value)
                            }
                          }
                        }),
                        _vm._v(" "),
                        _vm.has_error && _vm.errors.email
                          ? _c("span", { staticClass: "help-block" }, [
                              _vm._v(_vm._s(_vm.errors.email))
                            ])
                          : _vm._e()
                      ]
                    ),
                    _vm._v(" "),
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.password
                        }
                      },
                      [
                        _c("label", { attrs: { for: "password" } }, [
                          _vm._v("Password")
                        ]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.password,
                              expression: "form.password"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: { type: "password", id: "password" },
                          domProps: { value: _vm.form.password },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(
                                _vm.form,
                                "password",
                                $event.target.value
                              )
                            }
                          }
                        }),
                        _vm._v(" "),
                        _vm.has_error && _vm.errors.password
                          ? _c("span", { staticClass: "help-block" }, [
                              _vm._v(_vm._s(_vm.errors.password))
                            ])
                          : _vm._e()
                      ]
                    ),
                    _vm._v(" "),
                    _c(
                      "div",
                      {
                        staticClass: "form-group",
                        class: {
                          "has-error": _vm.has_error && _vm.errors.password
                        }
                      },
                      [
                        _c(
                          "label",
                          { attrs: { for: "password_confirmation" } },
                          [_vm._v("Password confirmation")]
                        ),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.form.password_confirmation,
                              expression: "form.password_confirmation"
                            }
                          ],
                          staticClass: "form-control",
                          attrs: {
                            type: "password",
                            id: "password_confirmation"
                          },
                          domProps: { value: _vm.form.password_confirmation },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.$set(
                                _vm.form,
                                "password_confirmation",
                                $event.target.value
                              )
                            }
                          }
                        })
                      ]
                    ),
                    _vm._v(" "),
                    _c("div", { staticClass: "form-group" }, [
                      _c("label", [_vm._v("Foto")]),
                      _vm._v(" "),
                      !_vm.form.foto
                        ? _c("div", [
                            _c("input", {
                              attrs: { type: "file" },
                              on: { change: _vm.onFileChange }
                            })
                          ])
                        : _c("div", [
                            _c("img", { attrs: { src: _vm.form.foto } }),
                            _vm._v(" "),
                            _c(
                              "button",
                              {
                                staticClass: "btn btn-danger btn-sm",
                                on: { click: _vm.removeImage }
                              },
                              [_vm._v("Hapus Foto")]
                            )
                          ])
                    ]),
                    _vm._v(" "),
                    _c(
                      "button",
                      {
                        staticClass: "btn btn-primary",
                        attrs: { type: "submit" }
                      },
                      [_vm._v("Submit")]
                    )
                  ]
                )
              : _vm._e()
          ])
        ])
      ])
    ])
  ])
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/pages/Register.vue":
/*!*****************************************!*\
  !*** ./resources/js/pages/Register.vue ***!
  \*****************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Register.vue?vue&type=template&id=364a2fac& */ "./resources/js/pages/Register.vue?vue&type=template&id=364a2fac&");
/* harmony import */ var _Register_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Register.vue?vue&type=script&lang=js& */ "./resources/js/pages/Register.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _Register_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__["render"],
  _Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/Register.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/Register.vue?vue&type=script&lang=js&":
/*!******************************************************************!*\
  !*** ./resources/js/pages/Register.vue?vue&type=script&lang=js& ***!
  \******************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_Register_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/babel-loader/lib??ref--4-0!../../../node_modules/vue-loader/lib??vue-loader-options!./Register.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/Register.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_Register_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/Register.vue?vue&type=template&id=364a2fac&":
/*!************************************************************************!*\
  !*** ./resources/js/pages/Register.vue?vue&type=template&id=364a2fac& ***!
  \************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../node_modules/vue-loader/lib??vue-loader-options!./Register.vue?vue&type=template&id=364a2fac& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/Register.vue?vue&type=template&id=364a2fac&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Register_vue_vue_type_template_id_364a2fac___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);