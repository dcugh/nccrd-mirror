﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NCCRD.Database.Models
{
    [Table("OptionRegion")]
    public class OptionRegion
    {
        public int OptionRegionId { get; set; }

        [Required]
        public Region Region { get; set; }

        [Required]
        public MAOption MAOption { get; set; }
    }
}