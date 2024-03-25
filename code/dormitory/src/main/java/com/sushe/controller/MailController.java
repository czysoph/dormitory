package com.sushe.controller;

import com.github.pagehelper.util.StringUtil;
import com.sushe.entity.User;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.internet.MimeMessage;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/mail")
public class MailController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Autowired
    private UserService userService;

    @RequestMapping("/send")
    public Result sendMail(@RequestBody User param){

        String email = param.getEmail();
        System.out.println(param.getEmail());
        String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);//生成短信验证码

        if (StringUtil.isEmpty(email)){
            return Result.fail("邮箱未填写");
        }
        List<User> list = userService.queryEmail(email);
        if (list == null || list.size() == 0) {
            return Result.fail("用户不存在");
        }
        if (list.size() > 1) {
            return Result.fail("邮箱填写出错");
        }
        User temp = list.get(0);

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("<html><head><title></title></head><body>");
        stringBuilder.append("您好").append(temp.getUserName()).append("<br/>");
        stringBuilder.append("您的验证码是：").append(verifyCode).append("<br/>");
        stringBuilder.append("您可以复制此验证码并返回，以验证您的邮箱。<br/>");
        stringBuilder.append("此验证码只能使用一次，在5分钟内有效。验证成功则自动失效。<br/>");
        stringBuilder.append("如果您没有进行上述操作，请忽略此邮件。");

        MimeMessage mimeMessage = mailSender.createMimeMessage();

        try {
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage,true);
            mimeMessageHelper.setFrom(from);    //这里只是设置username 并没有设置host和password，因为host和password在springboot启动创建JavaMailSender实例的时候已经读取了
            mimeMessageHelper.setTo(email);
            ((MimeMessage) mimeMessage).setSubject("邮箱验证-忘记密码");
            mimeMessageHelper.setText(stringBuilder.toString(),true);
            mailSender.send(mimeMessage);
//            mailSender.send(message);
            logger.info("邮件已发送。");

            User user = new User();
            user.setId(temp.getId());
            user.setVerifyCode(verifyCode);
            userService.updateSelective(user);

            return Result.ok("邮件已发送。");

        } catch (Exception e) {
            logger.error("发送邮件时发生异常！", e);
            return Result.fail("发送邮件时发生异常");
        }

    }

}