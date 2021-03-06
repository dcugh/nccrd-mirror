﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace NCCRD.Services.DataV2.Database.Models
{
    public class Person
    {
        public int PersonId { get; set; }

        [Required]
        [MaxLength(450)]
        public string EmailAddress { get; set; }

        [Required]
        [MaxLength(450)]
        public string FirstName { get; set; }

        [Required]
        [MaxLength(450)]
        public string Surname { get; set; }

        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }

        [Required]
        [MaxLength(450)]
        public string Organisation { get; set; }

        [MaxLength(450)]
        public string PhoneNumber { get; set; }

        [MaxLength(450)]
        public string MobileNumber { get; set; }
    }
}
