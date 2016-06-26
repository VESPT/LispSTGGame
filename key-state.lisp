;; 総称関数
(defgeneric update-key-state (key key-press key-state)
  (:documentation "キーの状態を更新する"))

;; キー入力の状態クラス
(defclass key-state()
  ((right
    :initform nil
    :documentation "右移動キーの状態")
   (left
    :initform nil
    :documentation "左移動キーの状態")))

;; key-stateクラスのメソッド実装
(defmethod update-key-state (key key-press (key-state key-state)) ;;引数３つ
  (with-slots (right left) key-state
    (cond ((sdl:key= key :sdl-key-right)
           (setf right key-press))
          ((sdl:key= key :sdl-key-left)
           (setf left key-press)))))
