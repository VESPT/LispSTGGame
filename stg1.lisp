(load "key-state.lisp" :external-format :utf-8)

(defun load-png-image (source-file)
  (sdl:convert-to-display-format :surface (sdl:load-image source-file)
                                 :enable-alpha t
                                 :pixel-alpha t))

(defun main ()
  (sdl:with-init ()
    (sdl:window 640 480 :title-caption "てすと") ; ウィンドウを作る
    (setf (sdl:frame-rate) 60) ; FPSを60に設定
    (sdl:initialise-default-font
     sdl:*font-10x20*) ; フォント初期化
    (let ((img (load-png-image "test.png")) ; 画像ファイルをロード
          (current-key-state (make-instance 'key-state)))

      (sdl:update-display) ; 画面更新

      ;; ここからイベント処理
      (sdl:with-events ()
        (:quit-event () t)
        (:key-down-event (:key key) ; キーを押した時の処理
           (if (sdl:key= key :sdl-key-escape)
             (sdl:push-quit-event)
             ;;(setf current-key key)
             (update-key-state key t current-key-state)));; 総称関数
        (:key-up-event (:key key)
             ;;(setf current-key nil)
             (update-key-state key nil current-key-state))
        (:idle ()
               ;; 描画する前に書いたものを消す
               (sdl:clear-display sdl:*black*)
               ;; 画像描画
               (sdl:draw-surface-at-* img ; 画像
                                      0 ; 左上頂点のX座標
                                      0); 左上頂点のY座標

               ;; 文字列描画 どのキーが押されたか表示
               (with-slots (right left) current-key-state
                 (sdl:draw-string-solid-*
                  (format nil "right:~:[no~;yes~]" right) 10 20)
                 (sdl:draw-string-solid-*
                  (format nil "left:~:[no~;yes~]" left) 10 40))

               ;; 四角形を描画
               (sdl:draw-box-* 10 ; 左上頂点のX座標
                               20 ; 左上の頂点のY座標
                               30 ; 幅
                               40 ; 高さ
                               :color sdl:*magenta* ; 中の色
                               :stroke-color sdl:*white*) ; 辺の色
               ;; 円を描画
               (sdl:draw-filled-circle-* 100 ; 中心のX座標
                                         200 ; 中心のY座標
                                         30  ; 半径
                                         :color sdl:*red*)

               ;; 文字列描画
               (sdl:draw-string-solid-* ; FPSを取得して文字列に変換
                                      (format nil "~,2F" (sdl:average-fps))
                                      ;(format t "test")
                                      300 ; 左上頂点のX座標
                                      400
                                      :color sdl:*red*); 左上頂点のY座標

               (sdl:update-display))))))
