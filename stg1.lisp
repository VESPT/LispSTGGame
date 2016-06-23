(defun main()
  (sdl:with-init ()
    (sdl:window 640 480 :title-caption "てすと") ; ウィンドウを作る
    (setf (sdl:frame-rate) 60) ; FPSを60に設定

    (sdl:update-display) ; 画面更新

    ;; ここからイベント処理
    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event (:key key)
                       (when (sdl:key= key :sdl-key-escape)
                         (sdl:push-quit-event)))
      (:idle ()
             ;; この中がゲームループ、今は空っぽ
             (sdl:update-display)))))
